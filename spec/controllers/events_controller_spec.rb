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
        @expected = {
          name: @name,
          description: @description,
          start_time: @start_time,
          end_time: @end_time,
        }

        post :create, params: { event: @expected }, format: :json

        expect(response).to have_http_status(:no_content)
        expect(Event.count).to eq(1)
        @created = Event.first
        # Created event start_time/end_timeare DateTime objects that can't be compared
        # to the originals, so manually compare attributes
        expect(@created.name).to eq(@name)
        expect(@created.description).to eq(@description)
        expect(@created.start_time.to_i).to eq(DateTime.parse(@start_time).to_i)
        expect(@created.end_time.to_i).to eq(DateTime.parse(@end_time).to_i)
      end

      it 'saves the form' do
        @name = 'cool event (cool kids only)'
        @description = 'what is a description'
        @start_time = 'Wed, 16 Sep 2020 05:27:32 GMT'
        @end_time = 'Wed, 16 Sep 2020 06:27:32 GMT'
        @form_type = 'sign-in'
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

        post :create, params: { event: @event_expected, form: @form_expected }, format: :json

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
    end

    context 'when given invalid event data' do
      it 'responds with bad request' do
        @expected = {
          name: 'Go back in time and uninvent ruby',
          description: 'yeah',
          start_time: 'aubergine',
          end_time: 'eggplant',
        }

        post :create, params: { event: @expected }, format: :json

        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
