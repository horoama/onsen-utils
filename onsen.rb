require 'net/http'
require 'json'
require 'date'
require 'pp'

class Onsen
    def initialize
        @base_url = 'http://www.onsen.ag/'
        @shownMovie_url = 'api/shownMovie/shownMovie.json'
        @getMovieInfo = 'data/api/getMovieInfo/'
    end

    def get_program_list
        uri = URI.parse(@base_url + @shownMovie_url)
        json = Net::HTTP.get uri
        data = JSON.parse(json)
        data
    end

    def get_program_info program
        uri = URI.parse(@base_url + @getMovieInfo + program)
        json = Net::HTTP.get uri
        data = JSON.parse(json.slice(9..json.length-4))
        data
    end

    def crawl #prev_data
        ret = {}
        programList = get_program_list['result']
        programList.each do |program|
            data = get_program_info program
            next if data['error']
            if data['update'] !=''
                date = Date.parse(data['update'])
                if data['count'].to_i > 0
                    ret["#{program}"] = data
                end
            end
        end
        ret
    end
end

#onsen = Onsen.new
#prev_data = open('./prev_data.json') do |io|
#  JSON.load(io)
#end
##pp prev_data
#ret = onsen.crawl #prev_data
#pp ret
#open('./prev_data.json',  'w') do |io|
#      JSON.dump(ret,  io)
#end
