require 'rails_helper'

describe Api::FormsController do
  describe 'GET show' do
    context 'when the given id matches with a form' do
      it 'returns the correct data about the form' do
        event_data = { id: 1, name: 'Test Event', description: 'description', event_type: 'GBM',
                       start_time: '2020-09-15T01:00:00.000Z', end_time: '2020-09-15T00:00:00.000Z' }
        @event = Event.create(event_data)
        form_data = { id: 'de12b1128f3', event_id: 1, start_time: '2020-09-15T01:00:00.000Z',
                      end_time: '2020-09-15T00:00:00.000Z', form_type: 'sign-in', questions: '[]' }
        @form = Form.create(form_data)

        get :show, params: { id: @form.id }, format: :json

        @json_response = JSON.parse response.body
        expect(@json_response['id']).to eq(@form.id)
        expect(@json_response['event_id']).to eq(@form.event_id)
        expect(@json_response['form_type']).to eq(@form.form_type)
        expect(@json_response['questions']).to eq(@form.questions)
        expect(@json_response['event']['name']).to eq(@event.name)
      end
    end

    context 'when the given id doe not match with a form' do
      it 'returns a not found status code' do
        @id = 'de12b1128f3'
        get :show, params: { id: @id }, format: :json
        expect(response).to have_http_status(:not_found)
      end
    end

    context 'when the given id is time-restricted and outside of its time range' do
      it 'returns a forbidden status code' do
        # Sign-In Past-Due
        event_data = { id: 1, name: 'Test Event', description: 'description', event_type: 'GBM',
                       start_time: '2020-09-15T01:00:00.000Z', end_time: '2020-09-15T00:00:00.000Z' }
        @event = Event.create(event_data)
        form_data = { id: '8888888887', event_id: 1, start_time: '2020-09-15T01:00:00.000Z',
                      end_time: '2020-09-15T00:00:00.000Z', form_type: 'sign-in', questions: '[]',
                      time_restricted: true }
        @sign_in_form = Form.create(form_data)
        expect(Form.count).to eq(1)
        @id = '8888888887'

        get :show, params: { id: @id }, format: :json
        expect(response).to have_http_status(:forbidden)
        Event.delete_all
        Form.delete_all
        expect(Form.count).to eq(0)

        # Sign-In Too Early
        event_data = { id: 1, name: 'Test Event', description: 'description', event_type: 'GBM',
                       start_time: 1.days.from_now, end_time: 1.days.from_now }
        @event = Event.create(event_data)
        form_data = { id: '8888888886', event_id: 1, start_time: 1.days.from_now,
                      end_time: 1.days.from_now, form_type: 'sign-in', questions: '[]',
                      time_restricted: true }
        @sign_in_form = Form.create(form_data)
        expect(Form.count).to eq(1)
        @id = '8888888886'

        get :show, params: { id: @id }, format: :json
        expect(response).to have_http_status(:forbidden)
        Event.delete_all
        Form.delete_all
        expect(Form.count).to eq(0)

        # RSVP Past-Due
        event_data = { id: 1, name: 'Test Event', description: 'description', event_type: 'GBM',
                       start_time: '2020-09-15T01:00:00.000Z', end_time: '2020-09-15T00:00:00.000Z' }
        @event = Event.create(event_data)
        form_data = { id: '8888888889', event_id: 1, start_time: '2020-09-15T01:00:00.000Z',
                      end_time: '2020-09-15T00:00:00.000Z', form_type: 'RSVP', questions: '[]', time_restricted: true }
        @rsvp_form = Form.create(form_data)
        expect(Form.count).to eq(1)
        @id = '8888888889'

        get :show, params: { id: @id }, format: :json
        expect(response).to have_http_status(:forbidden)
        Event.delete_all
        Form.delete_all
      end
    end
  end
end
