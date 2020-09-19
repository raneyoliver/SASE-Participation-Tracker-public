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
  end
end