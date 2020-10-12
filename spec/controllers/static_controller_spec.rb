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

  describe 'GET login' do
    it 'redirects to homepage' do
      get :login
      expect(response).to redirect_to('/')
    end
  end

  describe 'GET login without auth' do
    it 'redirects to login' do
      session[:current_user_id] = 1
      get :login
      expect(response).to render_template('index')
    end
  end

  describe 'GET index.js' do
    it 'renders javascript' do
      get :index_js, xhr: true, format: :js
      expect(response.content_type).to start_with('text/javascript')
    end
  end
end
