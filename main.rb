require 'sinatra'
require 'require_all'
require 'pry'
require 'dotenv'
require 'mysql2'
require 'sinatra/activerecord'
require 'jwt'

Dotenv.load

set :database_file, "./config/database.yml"

class Main < Sinatra::Base
  require_all './app/**/*.rb'
end
