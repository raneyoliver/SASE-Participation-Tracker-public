require 'rails_helper'

describe StaticController do
  before(:each) do
    @admin = Admin.new(username: 'testAdmin', password: '1234')
    @admin.save
    session[:current_user_id] = @admin.id
  end

  describe 'GET index' do
    it 'renders an HTML document' do
      get :index
      expect(response).to render_template('index')
    end
  end

  describe 'GET authorized index' do
    it 'redirects to login' do
      get :authorized_index
      expect(response).to render_template('index')
    end
  end
end
