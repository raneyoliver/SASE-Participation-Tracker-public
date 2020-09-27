require 'rails_helper'
require 'spec_helper'

describe Api::SessionsController do
  include Devise::Test::ControllerHelpers
  include Devise::TestHelpers
  before :each do
    @request.env['devise.mapping'] = Devise.mappings[:admin]
  end

  describe 'POST create' do
    context 'when invalid credentials are sent' do
      it 'returns invalid login attempt' do
        post :create, params: { username: 'test', password: 'test' }
        @expected = { error: 'invalid login attempt' }.to_json
        expect(response.body).to eq(@expected)
      end
    end
  end
end
