require 'rails_helper'

RSpec.describe 'Articles', type: :request do
  describe 'GET /index' do
    it 'respond with correct http status' do
      get articles_url
      expect(response).to have_http_status 200
    end

    it 'renders correct template' do
      get articles_url
      expect(response).to render_template('articles/index')
    end
  end

  describe 'POST /edit' do
    it 'receive form data' do
      put article_path(44), params: "{ title: 'ABC', body: 'DEF' }"
      expect(response).to have_http_status 200
    end
  end

end
