require './app/controllers/application_controller'
require './app/controllers/healthz_controller'

RSpec.describe HealthzController do
  describe 'index' do
    let(:response) { { status: 'ok' }.to_json }
    it 'return ok' do
      get('/')

      expect(last_response).to be_ok
      expect(last_response.body).to eq(response)
    end
  end
end
