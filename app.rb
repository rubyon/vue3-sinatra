require 'sinatra'
require 'sinatra/reloader'
require 'sinatra/namespace'
require 'sinatra/cross_origin'

class App < Sinatra::Base
  register Sinatra::CrossOrigin
  register Sinatra::Namespace

  configure do
    enable :cross_origin
    set :allow_origin, "*" # allows any origin(domain) to send fetch requests to your API
    set :allow_methods, [:get, :post, :patch, :delete, :options] # allows these HTTP verbs
    set :allow_credentials, true
    set :max_age, 1728000
    set :expose_headers, ['Content-Type']
  end

  options '*' do
    response.headers["Allow"] = "HEAD,GET,POST,DELETE,OPTIONS"
    response.headers["Access-Control-Allow-Headers"] = "X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept"
    200
  end

  configure :development do
    register Sinatra::Reloader
  end

  get '/' do
    File.read(File.join('public', 'index.html'))
  end

  namespace '/api/title' do
    get '' do
      content_type :json
      { title: "Vue.js 3.0 on Sinatra" }.to_json
    end
  end

  not_found do
    File.read(File.join('public', 'index.html'))
  end

end
