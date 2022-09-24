require 'rails_helper'

RSpec.describe 'Users', type: :request do
  context 'Correct response status' do
    describe 'GET /index' do
      it 'returns http success' do
        get '/'
        expect(response).to have_http_status(:success)
      end
    end

    describe 'GET /show' do
      it 'returns http success' do
        get '/users/1'
        expect(response).to have_http_status(:success)
      end
    end
  end
  context 'Correct template' do
    describe 'GET users' do
      it 'renders the index template' do
        get '/'
        expect(response).to render_template(:index)
        expect(response.body).to include('Users')
      end
      it 'renders the show template' do
        get '/users/1'
        expect(response).to render_template(:show)
        expect(response.body).to include('Bio')
      end
    end
  end
end
