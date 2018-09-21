require './app/controllers/application_controller'
require './app/controllers/url_controller'
require './app/models/url'
require_all './app/services/**/*.rb'
require './app/serializers/url_serializer'
require './app/services/url_service'

RSpec.describe UrlController do
  describe 'index' do
    let(:response) { { status: 'ok' }.to_json }
    it 'return ok' do
      get('/')

      expect(last_response).to be_ok
      # expect(last_response.body).to eq(response)
    end
  end

  describe 'post index' do
    let(:invalid_url) { { status: 'Not valid url' }.to_json }

    it 'return not valid url' do
      params = { url: 'http:||abc.com' }.to_json
      post('/', params)

      expect(last_response).to be_ok
      expect(last_response.body).to eq(invalid_url)
    end

    it 'created entity' do
      params = { url: 'http://www.abc.com' }.to_json
      post('/', params)

      expect(last_response.status).to eq(201)
      expect(JSON.parse(last_response.body)).to have_key('url')
      expect(JSON.parse(last_response.body)).to have_key('shorten')
    end

    it 'invalid json params' do
      params = { url: 'http://www.abc.com' }
      response = { message: 'Invalid JSON' }.to_json
      post('/', params)

      expect(last_response.body).to eq(response)
    end

    it 'short url already exist' do
      params = { url: 'http://www.abc.com', shorten: 'abc123' }.to_json
      response = { status: 'Short URL already exists' }.to_json
      post('/', params)
      post('/', params)

      expect(last_response.status).to eq(422)
      expect(last_response.body).to eq(response)
    end
  end

  describe 'delete url' do
    let(:params)    { 'abc123' }
    let(:responses)  { { status: 'Success' }.to_json }

    before do
      delete("/#{params}")
    end

    it 'success delete' do
      expect(last_response).to be_ok
      expect(JSON.parse(last_response.body)).to have_key('url')
      expect(JSON.parse(last_response.body)).to have_key('shorten')
    end

    it 'not found' do
      delete("/#{params}")

      expect(last_response).to be_not_found
      expect(last_response.body).to eq({status: 'Not found'}.to_json)
    end
  end
end
