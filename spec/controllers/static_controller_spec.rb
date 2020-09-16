describe StaticController do
  describe 'GET index' do
    it 'renders an HTML document' do
      get :index
      expect(response).to render_template('index')
    end
  end
end
