require 'rails_helper'

describe Api::UsersController do
  describe 'POST create_form_record_if_user_exists' do
    context 'when given a id that belongs to an existing user' do
      before :all do
        user_data = { id: '333333333', first_name: 'New', last_name: 'User', major: 'computer science',
                      graduation_year: 2021, email: 'email@address.com', phone_number: '333-333-3333' }
        @user = User.create(user_data)
      end
      it 'responds with a created status code' do
        @id = '333333333'
        post :create_form_record_if_user_exists, params: { id: @id }, format: :json
        expect(response).to have_http_status(:created)
      end
      after :all do
        User.delete_all
      end
    end

    context 'when given a id that does not belong to an existing user' do
      it 'responds with an ok status code' do
        @id = '333333333'
        post :create_form_record_if_user_exists, params: { id: @id }, format: :json
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when not given a id' do
      it 'responds with a bad request status code' do
        post :create_form_record_if_user_exists, params: {}, format: :json
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'POST create_user_and_form_record' do
    before :each do
      @id = '333333333'
      @first_name = 'New'
      @last_name = 'User'
      @major = 'computer science'
      @graduation_year = 2021
      @email = 'email@address.com'
      @phone_number = '333-333-3333'
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
    context 'when given valid user data' do
      it 'creates an event with all attributes' do
        post :create_user_and_form_record, params: { user: @expected }, format: :json

        expect(response).to have_http_status(:created)
        expect(User.count).to eq(1)

        @created = User.first
        expect(@created.id).to eq(@id)
        expect(@created.first_name).to eq(@first_name)
        expect(@created.last_name).to eq(@last_name)
        expect(@created.major).to eq(@major)
        expect(@created.graduation_year).to eq(@graduation_year)
        expect(@created.email).to eq(@email)
        expect(@created.phone_number).to eq(@phone_number)
      end
      it 'creates an event without a phone number' do
        @expected.delete(:phone_number)
        post :create_user_and_form_record, params: { user: @expected }, format: :json

        expect(response).to have_http_status(:created)
        expect(User.count).to eq(1)

        @created = User.first
        expect(@created.id).to eq(@id)
        expect(@created.first_name).to eq(@first_name)
        expect(@created.last_name).to eq(@last_name)
        expect(@created.major).to eq(@major)
        expect(@created.graduation_year).to eq(@graduation_year)
        expect(@created.email).to eq(@email)
        expect(@created.phone_number).to eq(nil)
      end
    end

    context 'when given invalid user data' do
      it 'does not create an event because of a missing id' do
        @expected.delete(:id)
        post :create_user_and_form_record, params: { user: @expected }, format: :json

        expect(response).to have_http_status(:bad_request)
        expect(User.count).to eq(0)
      end
      it 'does not create an event because of a missing first_name' do
        @expected.delete(:first_name)
        post :create_user_and_form_record, params: { user: @expected }, format: :json

        expect(response).to have_http_status(:bad_request)
        expect(User.count).to eq(0)
      end
      it 'does not create an event because of a missing last_name' do
        @expected.delete(:last_name)
        post :create_user_and_form_record, params: { user: @expected }, format: :json

        expect(response).to have_http_status(:bad_request)
        expect(User.count).to eq(0)
      end
      it 'does not create an event because of a missing major' do
        @expected.delete(:major)
        post :create_user_and_form_record, params: { user: @expected }, format: :json

        expect(response).to have_http_status(:bad_request)
        expect(User.count).to eq(0)
      end
      it 'does not create an event because of a missing graduation_year' do
        @expected.delete(:graduation_year)
        post :create_user_and_form_record, params: { user: @expected }, format: :json

        expect(response).to have_http_status(:bad_request)
        expect(User.count).to eq(0)
      end
      it 'does not create an event because of a missing email' do
        @expected.delete(:email)
        post :create_user_and_form_record, params: { user: @expected }, format: :json

        expect(response).to have_http_status(:bad_request)
        expect(User.count).to eq(0)
      end
      it 'does not create an event because of missing the user block' do
        @expected.delete(:email)
        post :create_user_and_form_record, params: {}, format: :json

        expect(response).to have_http_status(:bad_request)
        expect(User.count).to eq(0)
      end
    end
  end
end
