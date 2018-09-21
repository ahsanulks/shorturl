require './app/controllers/application_controller'
require './app/controllers/home_controller'

RSpec.describe HomeController do
  describe 'index' do
    let(:response) { { status: 'ok' }.to_json }
    it 'return ok' do
      get('/')

      expect(last_response).to be_ok
      expect(last_response.body).to eq(response)
    end
  end

  describe 'get shorten url' do
    let(:params) { { url: 'http://www.abc.com', shorten: 'abc123' } }
    before do
      url = Url.new
      url.url = params[:url]
      url.shorten = params[:shorten]
      url.save
    end

    it 'should redirect to long url' do
      get("/#{params[:shorten]}")

      expect(last_response.headers['location']).to eq(params[:url])
    end

    it 'shorten url not found' do
      get("/123456")

      expect(last_response).to be_not_found
      expect(last_response.body).to eq({status: 'Not found'}.to_json)
    end
  end
end
