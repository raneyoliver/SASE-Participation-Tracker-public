require 'rails_helper'

describe Api::FormUsersController do
  describe 'POST create' do
    context 'when given valid form user data and the form_user does not already exist' do
      before :each do
        user_data = { id: '95e229d8aca716874c8feca1501379e06f239d03', first_name: 'New', last_name: 'User',
                      major: 'computer science', graduation_year: 2021, email: 'email@address.com',
                      phone_number: '333-333-3333' }
        @user = User.create(user_data)
        @event_data = { id: 1, name: 'Test Event', description: 'description', event_type: 'GBM',
                        start_time: '2020-09-15T01:00:00.000Z', end_time: '2020-09-15T00:00:00.000Z' }
        Event.create(@event_data)
        form_data = { id: '8888888888', event_id: 1, start_time: '2020-09-15T01:00:00.000Z',
                      end_time: '2020-09-15T00:00:00.000Z', form_type: 'sign-in', questions: '[]' }
        @form = Form.create(form_data)
      end
      it 'saves the form user' do
        @form_id = '8888888888'
        @user_id = '333333333'
        @hashed_id = '95e229d8aca716874c8feca1501379e06f239d03'
        @expected = {
          form_id: @form_id,
          user_id: @user_id,
        }

        post :create, params: { form_user: @expected }, format: :json

        expect(response).to have_http_status(:created)

        expect(FormUser.count).to eq(1)

        @created = FormUser.first
        # compare to original
        expect(@created.form_id).to eq(@form_id)
        expect(@created.user_id).to eq(@hashed_id)
      end
      it 'sends a confirmation email' do
        @form_id = '8888888888'
        @user_id = '333333333'
        @hashed_id = '95e229d8aca716874c8feca1501379e06f239d03'
        @expected = {
          form_id: @form_id,
          user_id: @user_id,
        }

        expect { post :create, params: { form_user: @expected }, format: :json }
          .to have_enqueued_job(ActionMailer::MailDeliveryJob)
      end
    end

    context 'when given valid form user data and the form_user already exists' do
      before :all do
        user_data = { id: '95e229d8aca716874c8feca1501379e06f239d03', first_name: 'New', last_name: 'User',
                      major: 'computer science', graduation_year: 2021, email: 'email@address.com',
                      phone_number: '333-333-3333' }
        @user = User.create(user_data)
        @event_data = { id: 1, name: 'Test Event', description: 'description',
                        start_time: '2020-09-15T01:00:00.000Z', end_time: '2020-09-15T00:00:00.000Z' }
        Event.create(@event_data)
        form_data = { id: '8888888888', event_id: 1, start_time: '2020-09-15T01:00:00.000Z',
                      end_time: '2020-09-15T00:00:00.000Z', form_type: 'sign-in', questions: '[]' }
        @form = Form.create(form_data)
        form_user_data = { form_id: @form.id, user_id: @user.id }
        @form_user = FormUser.create(form_user_data)
      end
      it 'does not create another form_user' do
        @form_id = '8888888888'
        @user_id = '333333333'
        @hashed_id = '95e229d8aca716874c8feca1501379e06f239d03'
        @expected = {
          form_id: @form_id,
          user_id: @user_id,
        }

        post :create, params: { form_user: @expected }, format: :json

        expect(response).to have_http_status(:ok)

        expect(FormUser.count).to eq(1)

        @existing = FormUser.first

        expect(@existing.form_id).to eq(@form_id)
        expect(@existing.user_id).to eq(@hashed_id)
      end
      after :all do
        User.delete_all
        Form.delete_all
        Event.delete_all
        FormUser.delete_all
      end
    end
    context 'when given invalid form user data' do
      it 'responds with bad request because of invalid form_user data' do
        @expected = {
          form_id: 4_324_234,
          user_id: 234_235,
        }
        post :create, params: { form_user: @expected }, format: :json
        expect(response).to have_http_status(:bad_request)
      end
      it 'responds with bad request because of the missing block' do
        post :create, params: {}, format: :json
        expect(response).to have_http_status(:bad_request)
      end
    end
  end
end
