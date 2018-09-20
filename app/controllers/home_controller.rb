class HomeController < ApplicationController
  get('/:shorten') do
    url = Url.find_by(shorten: params['shorten'])
    redirect url.url
  end

  get('/') do
    respond_status('ok')
  end
end
