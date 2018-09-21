class HomeController < ApplicationController
  get('/:shorten') do
    url = Url.find_by(shorten: params['shorten'])
    if url.present?
      redirect url.url
    else
      status 404
      body respond_status('Not found')
    end
  end

  get('/') do
    respond_status('ok')
  end
end
