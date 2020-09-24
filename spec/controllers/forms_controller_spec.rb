require 'rails_helper'

describe Api::FormsController do
  describe 'GET show' do
    context 'when the given id matches with a form' do
      it 'returns the correct data about the form' do
        event_data = { id: 1, name: 'Test Event', description: 'description',
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
  end
end
