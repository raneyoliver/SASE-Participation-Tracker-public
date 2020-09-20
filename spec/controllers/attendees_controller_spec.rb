require 'rails_helper'

describe Api::AttendeesController do
  describe 'POST create_form_record_if_attendee_exists' do
    context 'when given a UIN that belongs to an existing attendee' do
      before :all do
        attendee_data = { UIN: '333333333', first_name: 'New', last_name: 'User', major: 'computer science',
                          graduation_year: 2021, email: 'email@address.com', phone_number: '333-333-3333' }
        @attendee = Attendee.create(attendee_data)
      end
      it 'responds with a created status code' do
        @UIN = '333333333'
        post :create_form_record_if_attendee_exists, params: { UIN: @UIN }, format: :json
        expect(response).to have_http_status(:created)
      end
      after :all do
        Attendee.delete_all
      end
    end

    context 'when given a UIN that does not belong to an existing attendee' do
      it 'responds with an ok status code' do
        @UIN = '333333333'
        post :create_form_record_if_attendee_exists, params: { UIN: @UIN }, format: :json
        expect(response).to have_http_status(:ok)
      end
    end

    context 'when not given a UIN' do
      it 'responds with a bad request status code' do
        post :create_form_record_if_attendee_exists, params: {}, format: :json
        expect(response).to have_http_status(:bad_request)
      end
    end
  end

  describe 'POST create_attendee_and_form_record' do
    before :each do
      @UIN = '333333333'
      @first_name = 'New'
      @last_name = 'User'
      @major = 'computer science'
      @graduation_year = 2021
      @email = 'email@address.com'
      @phone_number = '333-333-3333'
      @expected = {
        UIN: @UIN,
        first_name: @first_name,
        last_name: @last_name,
        major: @major,
        graduation_year: @graduation_year,
        email: @email,
        phone_number: @phone_number,
      }
    end
    context 'when given valid attendee data' do
      it 'creates an event with all attributes' do
        post :create_attendee_and_form_record, params: { attendee: @expected }, format: :json

        expect(response).to have_http_status(:created)
        expect(Attendee.count).to eq(1)

        @created = Attendee.first
        expect(@created.UIN).to eq(@UIN)
        expect(@created.first_name).to eq(@first_name)
        expect(@created.last_name).to eq(@last_name)
        expect(@created.major).to eq(@major)
        expect(@created.graduation_year).to eq(@graduation_year)
        expect(@created.email).to eq(@email)
        expect(@created.phone_number).to eq(@phone_number)
      end
      it 'creates an event without a phone number' do
        @expected.delete(:phone_number)
        post :create_attendee_and_form_record, params: { attendee: @expected }, format: :json

        expect(response).to have_http_status(:created)
        expect(Attendee.count).to eq(1)

        @created = Attendee.first
        expect(@created.UIN).to eq(@UIN)
        expect(@created.first_name).to eq(@first_name)
        expect(@created.last_name).to eq(@last_name)
        expect(@created.major).to eq(@major)
        expect(@created.graduation_year).to eq(@graduation_year)
        expect(@created.email).to eq(@email)
        expect(@created.phone_number).to eq(nil)
      end
    end

    context 'when given invalid attendee data' do
      it 'does not create an event because of a missing UIN' do
        @expected.delete(:UIN)
        post :create_attendee_and_form_record, params: { attendee: @expected }, format: :json

        expect(response).to have_http_status(:bad_request)
        expect(Attendee.count).to eq(0)
      end
      it 'does not create an event because of a missing first_name' do
        @expected.delete(:first_name)
        post :create_attendee_and_form_record, params: { attendee: @expected }, format: :json

        expect(response).to have_http_status(:bad_request)
        expect(Attendee.count).to eq(0)
      end
      it 'does not create an event because of a missing last_name' do
        @expected.delete(:last_name)
        post :create_attendee_and_form_record, params: { attendee: @expected }, format: :json

        expect(response).to have_http_status(:bad_request)
        expect(Attendee.count).to eq(0)
      end
      it 'does not create an event because of a missing major' do
        @expected.delete(:major)
        post :create_attendee_and_form_record, params: { attendee: @expected }, format: :json

        expect(response).to have_http_status(:bad_request)
        expect(Attendee.count).to eq(0)
      end
      it 'does not create an event because of a missing graduation_year' do
        @expected.delete(:graduation_year)
        post :create_attendee_and_form_record, params: { attendee: @expected }, format: :json

        expect(response).to have_http_status(:bad_request)
        expect(Attendee.count).to eq(0)
      end
      it 'does not create an event because of a missing email' do
        @expected.delete(:email)
        post :create_attendee_and_form_record, params: { attendee: @expected }, format: :json

        expect(response).to have_http_status(:bad_request)
        expect(Attendee.count).to eq(0)
      end
      it 'does not create an event because of missing the attendee block' do
        @expected.delete(:email)
        post :create_attendee_and_form_record, params: {}, format: :json

        expect(response).to have_http_status(:bad_request)
        expect(Attendee.count).to eq(0)
      end
    end
  end
end
