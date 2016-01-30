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
    haml :index
end
#    program = onsen.get_program_list[:result]
#    programs.each do |program|
#	puts program
#    end
#
class Stream
    def each
	200.times { |i| yield "#{i}\n" }
    end
end

get('/hoge') { Stream.new }
