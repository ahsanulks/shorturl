require 'uri'

class UrlController < ApplicationController

  get('/') do
  end

  post('/') do
    return respond_status('Not valid url') if valid_url?(json_params['url'])

    url = UrlService.create(json_params['url'], json_params['shorten'])
    if url.is_a?(Url)
      url.save
      status 201
      render_serializer(url, 'UrlSerializer')
    else
      status 422
      body respond_status(url.message)
    end
  end

  delete('/:shorten') do
    url = Url.find_by(shorten: params['shorten'])
    if url.present?
       url.delete
       render_serializer(url, 'UrlSerializer')
    else
      status 404
      body respond_status('Not found')
    end

  end

  private
  def valid_url?(url)
    (url =~ /\A#{URI::regexp}\z/).nil?
  end
end
