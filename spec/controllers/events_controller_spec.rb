require 'rails_helper'

describe Api::EventsController do
  before(:each) do
    @admin = Admin.new(username: 'testAdmin', password: '1234')
    @admin.save
    session[:current_user_id] = @admin.id
  end

  describe 'GET list' do
    context 'when no events are created' do
      it 'returns empty array' do
        @expected = [].to_json
        get :list

        expect(response.body).to eq(@expected)
      end
    end

    context 'when one event is created' do
      it 'returns an array with the created event and forms it contains' do
        @expected_event = {
          id: 1,
          name: 'Test Event',
          description: 'description goes here',
          start_time: '2020-09-15T01:00:00.000Z',
          end_time: '2020-09-15T00:00:00.000Z',
          event_type: 'Socials',
        }
        Event.new(**@expected_event).save

        @expected_form = {
          id: '8888888888',
          event_id: 1,
          start_time: '2020-09-15T01:00:00.000Z',
          end_time: '2020-09-15T00:00:00.000Z',
          form_type: 'sign-in',
          questions: '[]',
        }
        Form.new(**@expected_form).save

        @expected_response = {
          id: 1,
          name: 'Test Event',
          description: 'description goes here',
          start_time: '2020-09-15T01:00:00.000Z',
          end_time: '2020-09-15T00:00:00.000Z',
          event_type: 'Socials',
          forms: [{
            id: '8888888888',
            form_type: 'sign-in',
            user_count: 0,
          }],
        }

        get :list

        @expected_response = @expected_response.stringify_keys
        @expected_response['forms'][0] = @expected_response['forms'][0].stringify_keys
        @json_response = JSON.parse response.body
        expect(@json_response.length).to eq(1)
        expect(@json_response[0]).to match(@expected_response)
      end
    end
  end

  describe 'POST create' do
    context 'when given valid event data' do
      it 'saves the event' do
        @name = 'cool event (cool kids only)'
        @description = 'what is a description'
        @start_time = 'Wed, 16 Sep 2020 05:27:32 GMT'
        @end_time = 'Wed, 16 Sep 2020 06:27:32 GMT'
        @create_rsvp_form = false
        @event_type = 'GBM'
        @sign_in_restricted = false
        @rsvp_restricted = false
        @has_rsvp_form = false
        @expected = {
          name: @name,
          description: @description,
          start_time: @start_time,
          end_time: @end_time,
          event_type: @event_type,
          sign_in_restricted: @sign_in_restricted,
          rsvp_restricted: @rsvp_restricted,
          has_rsvp_form: @has_rsvp_form,
        }

        post :create, params: { event: @expected, create_rsvp_form: @create_rsvp_form }, as: :json

        expect(response).to have_http_status(:no_content)
        expect(Event.count).to eq(1)
        @created = Event.first
        # Created event start_time/end_timeare DateTime objects that can't be compared
        # to the originals, so manually compare attributes
        expect(@created.name).to eq(@name)
        expect(@created.description).to eq(@description)
        expect(@created.start_time.to_i).to eq(DateTime.parse(@start_time).to_i)
        expect(@created.end_time.to_i).to eq(DateTime.parse(@end_time).to_i)
        expect(@created.event_type).to eq(@event_type)
        expect(@created.sign_in_restricted).to eq @sign_in_restricted
        expect(@created.rsvp_restricted).to eq @rsvp_restricted
        expect(@created.has_rsvp_form).to eq @has_rsvp_form
      end

      it 'only creates a sign-in form when not told to create an RSVP form' do
        @name = 'cool event (cool kids only)'
        @description = 'what is a description'
        @start_time = 'Wed, 16 Sep 2020 05:27:32 GMT'
        @end_time = 'Wed, 16 Sep 2020 06:27:32 GMT'
        @create_rsvp_form = false
        @form_type = 'sign-in'
        @questions = '[]'

        @event_expected = {
          name: @name,
          description: @description,
          start_time: @start_time,
          end_time: @end_time,
          event_type: @event_type,
        }

        @form_expected = {
          event_id: Event.primary_key,
          start_time: @start_time,
          end_time: @end_time,
          form_type: @form_type,
          questions: @questions,
        }

        post :create, params: { event: @event_expected,
                                form: @form_expected,
                                create_rsvp_form: @create_rsvp_form }, as: :json

        expect(response).to have_http_status(:no_content)
        expect(Form.count).to eq(1)
        @created = Form.first
        expect(@created.start_time.to_i).to eq(DateTime.parse(@start_time).to_i)
        expect(@created.end_time.to_i).to eq(DateTime.parse(@end_time).to_i)
        expect(@created.form_type).to eq(@form_type)
        expect(@created.questions).to eq(@questions)

        # Check if the form is linked to the event created
        expect(@created.event_id).to eq(Event.first.id)

        # Check if the form has a unique id (link)
        expect(@created.id)
      end

      it 'creates an RSVP form when told to' do
        @name = 'cool event (cool kids only)'
        @description = 'what is a description'
        @start_time = 'Wed, 16 Sep 2020 05:27:32 GMT'
        @end_time = 'Wed, 16 Sep 2020 06:27:32 GMT'
        @create_rsvp_form = true
        @form_type = 'RSVP'
        @questions = '[]'
        @event_expected = {
          name: @name,
          description: @description,
          start_time: @start_time,
          end_time: @end_time,
        }

        @form_expected = {
          event_id: Event.primary_key,
          start_time: @start_time,
          end_time: @end_time,
          form_type: @form_type,
          questions: @questions,
        }

        post :create, params: { event: @event_expected,
                                form: @form_expected,
                                create_rsvp_form: @create_rsvp_form }, as: :json

        expect(response).to have_http_status(:no_content)
        expect(Form.count).to eq(2)
        @created = Form.where(form_type: 'RSVP').first
        expect(@created.start_time.to_i).to eq(DateTime.parse(@start_time).to_i)
        expect(@created.end_time.to_i).to eq(DateTime.parse(@end_time).to_i)
        expect(@created.form_type).to eq(@form_type)
        expect(@created.questions).to eq(@questions)

        # Check if the form is linked to the event created
        expect(@created.event_id).to eq(Event.first.id)

        # Check if the form has a unique id (link)
        expect(@created.id)
      end
    end

    context 'when given invalid event data' do
      it 'responds with bad request' do
        @expected = {
          name: 'Go back in time and uninvent ruby',
          description: 'yeah',
          start_time: 'aubergine',
          end_time: 'eggplant',
          event_type: 'badtype',
        }

        post :create, params: { event: @expected }, as: :json

        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'POST add_form' do
    before(:each) do
      @expected = {
        name: 'dummy edit event name',
        description: 'dummy edit event discription',
        start_time: 'Wed, 16 Sep 2020 05:27:32 GMT',
        end_time: 'Wed, 16 Sep 2020 06:27:32 GMT',
      }
      Event.new(**@expected).save
      expect(Event.count).to eq(1)
    end

    context 'when given valid event id' do
      it 'creates new form for event' do
        @start_time = 'Wed, 16 Sep 2020 05:27:32 GMT'
        @end_time = 'Wed, 16 Sep 2020 06:27:32 GMT'
        @form_type = 'RSPV'
        @questions = '[]'

        # get event
        expect(Event.count).to eq(1)
        expect(Form.count).to eq(0)
        @created = Event.first

        post :add_form, params: { id: @created.id, form_type: @form_type }, format: :json

        expect(response).to have_http_status(:no_content)

        # check to see that there were no added events
        expect(Event.count).to eq(1)
        @created = Event.first

        # check to see if forms was added
        expect(Form.count).to eq(1)
        @created_form = Form.first

        expect(@created_form.start_time.to_i).to eq(DateTime.parse(@start_time).to_i)
        expect(@created_form.end_time.to_i).to eq(DateTime.parse(@end_time).to_i)
        expect(@created_form.form_type).to eq(@form_type)
        expect(@created_form.questions).to eq(@questions)

        # remove any objects created
        Form.delete_all
        Event.delete_all
      end
    end

    context 'when given invalid event id' do
      it 'does not save form' do
        # get event
        expect(Event.count).to eq(1)
        expect(Form.count).to eq(0)
        @created = Event.first

        post :add_form, params: { id: 144_131_564, form_type: @form_type }, format: :json

        expect(response).to have_http_status(:not_found)

        # no changes should be made
        expect(Event.count).to eq(1)
        expect(Form.count).to eq(0)

        # remove any objects created
        Event.delete_all
        Form.delete_all
      end
    end
  end

  describe 'GET edit' do
    before(:each) do
      @expected = {
        name: 'dummy edit event name',
        description: 'dummy edit event discription',
        start_time: 'Wed, 16 Sep 2020 05:27:32 GMT',
        end_time: 'Wed, 16 Sep 2020 06:27:32 GMT',
      }
      Event.new(**@expected).save
      expect(Event.count).to eq(1)
    end

    context 'when given valid event' do
      it 'returns event data' do
        @name = 'dummy edit event name'
        @description = 'dummy edit event discription'
        @start_time = 'Wed, 16 Sep 2020 05:27:32 GMT'
        @end_time = 'Wed, 16 Sep 2020 06:27:32 GMT'

        # get event
        expect(Event.count).to eq(1)
        @created = Event.first

        # delete event
        get :edit, params: { id: @created.id }, format: :json

        expect(response).to have_http_status(:ok)

        @json_response = JSON.parse response.body

        # Created event start_time/end_timeare DateTime objects that can't be compared
        # to the originals, so manually compare attributes
        expect(@json_response['name']).to eq(@name)
        expect(@json_response['description']).to eq(@description)
        expect(DateTime.parse(@json_response['start_time']).to_i).to eq(DateTime.parse(@start_time).to_i)
        expect(DateTime.parse(@json_response['end_time']).to_i).to eq(DateTime.parse(@end_time).to_i)

        # remove any objects created
        Event.delete_all
      end
    end

    context 'when given non-existing event' do
      it 'responds with not found' do
        # check that we have at least one event
        expect(Event.count).to eq(1)

        # delete non-existing event
        get :edit, params: { id: 34_234_234 }, format: :json

        expect(response).to have_http_status(:not_found)

        # check to make sure event it still in database
        expect(Event.count).to eq(1)

        # remove any objects created
        Event.delete_all
      end
    end
  end

  describe 'POST update' do
    before(:each) do
      @expected = {
        name: 'dummy event name',
        description: 'dummy event discription',
        start_time: 'Wed, 16 Sep 2020 05:27:32 GMT',
        end_time: 'Wed, 16 Sep 2020 06:27:32 GMT',
      }
      Event.new(**@expected).save
      expect(Event.count).to eq(1)
    end

    context 'when given valid event and event data' do
      it 'updates the event' do
        # get event
        expect(Event.count).to eq(1)
        @created = Event.first

        # create content for updated event
        @updated_name = 'dummy updated event name'
        @updated_description = 'dummy updated event description'
        @updated_start_time = 'Wed, 16 Sep 2020 05:27:20 GMT'
        @updated_end_time = 'Wed, 16 Sep 2020 06:27:10 GMT'
        @updated_event = {
          name: @updated_name,
          description: @updated_description,
          start_time: @updated_start_time,
          end_time: @updated_end_time,
        }

        # update event
        post :update, params: { event: @updated_event, id: @created.id }, format: :json

        expect(response).to have_http_status(:no_content)
        expect(Event.count).to eq(1)

        @updated = Event.find(@created.id)

        # Created event start_time/end_timeare DateTime objects that can't be compared
        # to the originals, so manually compare attributes
        expect(@updated.name).to eq(@updated_name)
        expect(@updated.description).to eq(@updated_description)
        expect(@updated.start_time.to_i).to eq(DateTime.parse(@updated_start_time).to_i)
        expect(@updated.end_time.to_i).to eq(DateTime.parse(@updated_end_time).to_i)

        # remove any objects created
        Event.delete_all
      end
    end

    context 'when given invalid event data' do
      it 'responds with bad request' do
        # get event
        expect(Event.count).to eq(1)
        @created = Event.first

        @updated_event = {
          description: 'dummy event discription',
          start_time: 'dummy invalid event start time',
          end_time: 'dummy invalid event end time',
        }

        post :update, params: { event: @updated_event, id: @created.id }, format: :json

        expect(response).to have_http_status(:bad_request)

        # remove any objects created
        Event.delete_all
      end
    end

    context 'when given non existing event' do
      it 'responds with not found' do
        @updated_event = {
          id: 213_124_324,
          name: 'dummy event name',
          description: 'dummy event discription',
          start_time: 'Wed, 16 Sep 2020 05:27:32 GMT',
          end_time: 'Wed, 16 Sep 2020 06:27:32 GMT',
        }

        post :update, params: { event: @updated_event }, format: :json

        expect(response).to have_http_status(:not_found)

        # remove any objects created
        Event.delete_all
      end
    end
  end

  describe 'POST delete' do
    before(:each) do
      @expected = {
        name: 'dummy delete event name',
        description: 'dummy delete event discription',
        start_time: 'Wed, 16 Sep 2020 05:27:32 GMT',
        end_time: 'Wed, 16 Sep 2020 06:27:32 GMT',
      }
      Event.new(**@expected).save
      expect(Event.count).to eq(1)
    end

    context 'when given valid event' do
      it 'deletes the event' do
        # get event
        expect(Event.count).to eq(1)
        @created = Event.first

        # delete event
        post :delete, params: { id: @created.id }, format: :json

        expect(response).to have_http_status(:no_content)

        # event is no longer in database
        expect(Event.count).to eq(0)

        # remove any objects created
        Event.delete_all
      end
    end

    context 'when given non-existing event' do
      it 'responds with not found' do
        # check that we have at least one event
        expect(Event.count).to eq(1)

        # delete non-existing event
        post :delete, params: { id: 34_234_234 }, format: :json

        expect(response).to have_http_status(:not_found)

        # check to make sure event it still in database
        expect(Event.count).to eq(1)

        # remove any objects created
        Event.delete_all
      end
    end
  end

  describe 'GET export' do
    context 'when no events are created' do
      it 'returns empty array' do
        @expected = [].to_json
        get :export

        expect(response.body).to eq(@expected)
      end
    end

    context 'when one event is created' do
      it 'returns an array with the created event and user info it contains' do
        @expected_event = {
          id: 1,
          name: 'Test Event',
          description: 'description goes here',
          start_time: '2020-09-15T01:00:00.000Z',
          end_time: '2020-09-15T00:00:00.000Z',
          event_type: 'Socials',
        }
        Event.new(**@expected_event).save

        @expected_form = {
          id: '8888888888',
          event_id: 1,
          start_time: '2020-09-15T01:00:00.000Z',
          end_time: '2020-09-15T00:00:00.000Z',
          form_type: 'sign-in',
          questions: '[]',
        }
        Form.new(**@expected_form).save

        @expected_user = {
          id: '95e229d8aca716874c8feca1501379e06f239d03',
          first_name: 'New',
          last_name: 'User',
          major: 'computer science',
          graduation_year: 2021,
          email: 'email@address.com',
          phone_number: '333-333-3333',
        }
        User.new(**@expected_user).save

        @expected_form_user = {
          id: 1,
          form_id: '8888888888',
          user_id: '95e229d8aca716874c8feca1501379e06f239d03',
        }
        @form_user = FormUser.new(**@expected_form_user)
        @form_user.save

        @expected_response = {
          event_id: 1,
          event_name: 'Test Event',
          event_type: 'Socials',
          form_id: '8888888888',
          form_type: 'sign-in',
          user_id: '95e229d8aca716874c8feca1501379e06f239d03',
          first_name: 'New',
          last_name: 'User',
          email: 'email@address.com',
          phone_number: '333-333-3333',
        }

        get :export

        @expected_response = @expected_response.stringify_keys
        @json_response = JSON.parse response.body
        expect(Event.count).to eq(1)
        expect(Form.count).to eq(1)
        expect(@form_user).to be_valid
        expect(User.count).to eq(1)
        expect(@json_response[0]).to match(@expected_response)
      end
    end
  end
end
