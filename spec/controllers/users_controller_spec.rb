require 'rails_helper'

describe Api::UsersController do
  describe 'POST handle_identification' do
    context 'when given a id that belongs to an existing user' do
      before :all do
        user_data = { id: '95e229d8aca716874c8feca1501379e06f239d03', first_name: 'New', last_name: 'User',
                      major: 'computer science', graduation_year: 2021, email: 'email@address.com',
                      phone_number: '3333333333' }
        @user = User.create(user_data)
      end
      it 'responds with a created status code' do
        @id = '333333333'
        post :handle_identification, params: { id: @id }, format: :json
        expect(response).to have_http_status(:created)
      end
      after :all do
        User.delete_all
      end
    end

    context 'when given a id that does not belong to an existing user' do
      it 'responds with an ok status code' do
        @id = '333333333'
        post :handle_identification, params: { id: @id }, format: :json
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when not given a id' do
      it 'responds with a bad request status code' do
        post :handle_identification, params: {}, format: :json
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'POST create' do
    before :each do
      @id = '333333333'
      @hashed_id = '95e229d8aca716874c8feca1501379e06f239d03'
      @first_name = 'New'
      @last_name = 'User'
      @major = 'computer science'
      @graduation_year = 2021
      @email = 'email@address.com'
      @phone_number = '3333333333'
      @expected = {
        id: @id,
        first_name: @first_name,
        last_name: @last_name,
        major: @major,
        graduation_year: @graduation_year,
        email: @email,
        phone_number: @phone_number,
      }
    end
    context 'when given valid user data for a nonexistent user' do
      it 'creates an event with all attributes' do
        post :create, params: { user: @expected }, format: :json

        expect(response).to have_http_status(:created)
        expect(User.count).to eq(1)

        @created = User.first
        expect(@created.id).to eq(@hashed_id)
        expect(@created.first_name).to eq(@first_name)
        expect(@created.last_name).to eq(@last_name)
        expect(@created.major).to eq(@major)
        expect(@created.graduation_year).to eq(@graduation_year)
        expect(@created.email).to eq(@email)
        expect(@created.phone_number).to eq(@phone_number)
      end
      it 'creates an user without a phone number' do
        @expected.delete(:phone_number)
        post :create, params: { user: @expected }, format: :json

        expect(response).to have_http_status(:created)
        expect(User.count).to eq(1)

        @created = User.first
        expect(@created.id).to eq(@hashed_id)
        expect(@created.first_name).to eq(@first_name)
        expect(@created.last_name).to eq(@last_name)
        expect(@created.major).to eq(@major)
        expect(@created.graduation_year).to eq(@graduation_year)
        expect(@created.email).to eq(@email)
        expect(@created.phone_number).to eq(nil)
      end
      it 'sends a new user email' do
        expect { post :create, params: { user: @expected }, format: :json }
          .to have_enqueued_job(ActionMailer::MailDeliveryJob)
      end
    end

    context 'when given valid user data for an existing user' do
      it 'does not create a user' do
        user_data = { id: '95e229d8aca716874c8feca1501379e06f239d03', first_name: 'New', last_name: 'User',
                      major: 'computer science', graduation_year: 2021, email: 'email@address.com',
                      phone_number: '3333333333' }
        @user = User.create(user_data)
        post :create, params: { user: @expected }, format: :json

        expect(response).to have_http_status(:conflict)
        expect(User.count).to eq(1)
      end
    end

    context 'when given invalid user data' do
      it 'does not create an user because of a missing id' do
        @expected.delete(:id)
        post :create, params: { user: @expected }, format: :json

        expect(response).to have_http_status(:bad_request)
        expect(User.count).to eq(0)
      end
      it 'does not create an user because of a missing first_name' do
        @expected.delete(:first_name)
        post :create, params: { user: @expected }, format: :json

        expect(response).to have_http_status(:bad_request)
        expect(User.count).to eq(0)
      end
      it 'does not create an user because of a missing last_name' do
        @expected.delete(:last_name)
        post :create, params: { user: @expected }, format: :json

        expect(response).to have_http_status(:bad_request)
        expect(User.count).to eq(0)
      end
      it 'does not create an user because of a missing major' do
        @expected.delete(:major)
        post :create, params: { user: @expected }, format: :json

        expect(response).to have_http_status(:bad_request)
        expect(User.count).to eq(0)
      end
      it 'does not create an user because of a missing graduation_year' do
        @expected.delete(:graduation_year)
        post :create, params: { user: @expected }, format: :json

        expect(response).to have_http_status(:bad_request)
        expect(User.count).to eq(0)
      end
      it 'does not create an user because of a missing email' do
        @expected.delete(:email)
        post :create, params: { user: @expected }, format: :json

        expect(response).to have_http_status(:bad_request)
        expect(User.count).to eq(0)
      end
      it 'does not create an user because of missing the user block' do
        @expected.delete(:email)
        post :create, params: {}, format: :json

        expect(response).to have_http_status(:bad_request)
        expect(User.count).to eq(0)
      end
    end
  end
end
