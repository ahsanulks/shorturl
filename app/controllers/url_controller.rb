require 'uri'

class UrlController < ApplicationController

  get('/') do
  end

  post('/') do
    return respond_status('Not valid url') if valid_url?(json_params['url'])
    url = UrlService.create(json_params['url'], json_params['shorten'])
    if url.save
      status 201
      render_serializer(url, 'UrlSerializer')
    else
      status 422
      body render_serializer(url, 'Urlserializer')
    end
  end

  delete('/:shorten') do
    Url.find_by(shorten: params['shorten']).delete
    respond_status('Success')
  end

  private
  def valid_url?(url)
    (url =~ /\A#{URI::regexp}\z/).nil?
  end
end
