class HealthzController < ApplicationController

  get('/') do
    respond_status('ok')
  end
end
