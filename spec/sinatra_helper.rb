require 'simplecov'
require 'pry'
require 'rack/test'
require 'rspec'
require 'require_all'
require 'mysql2'
require 'sinatra/activerecord'
require 'dotenv'

ENV['RACK_ENV'] = 'test'
ENV['SHORTURL_ENV'] = 'test'

module RSpecMixin
  include Rack::Test::Methods

  def app
    described_class
  end
end

RSpec.configure do |c|
  c.include RSpecMixin
end
