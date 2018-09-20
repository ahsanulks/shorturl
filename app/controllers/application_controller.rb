require 'sinatra'

class ApplicationController < Sinatra::Base

  before do
    content_type 'application/json'
  end

  helpers do
    def base_url
      @base_url ||= "#{request.env['rack.url_scheme']}://{request.env['HTTP_HOST']}"
    end

    def json_params
      @json_params ||= JSON.parse(request.body.read)
    rescue
      halt 400, { message: 'Invalid JSON' }.to_json
    end
  end

  protected

  def respond_status(message)
    { status: message }.to_json
  end

  def render_serializer(resource, serializer)
    serializer.constantize.new(resource).to_json rescue respond_status('not found')
  end
end
