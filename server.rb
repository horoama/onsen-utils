require 'sinatra'
require 'net/http'
require 'json'
require 'date'
require 'pp'
require 'haml'
require './onsen.rb'

set :bind, '0.0.0.0'
set :haml, :format => :html5

onsen = Onsen.new

get('/') do
    @data = onsen.get_program_list
    haml :index
end

get('/program/:name') do
    @data = onsen.get_program_info "#{params['name']}"
    haml :program
end
