class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  def hello
    uri = URI.parse('http://api.syosetu.com/novelapi/api/?out=json&lim=500$gzip=5')
    json = Net::HTTP.get(uri)
    result = JSON.parse(json)
    result2= JSON.pretty_generate(result)
    render json: result2
    # json.each do |data|
    #   Book.create(column1:data['ncode'],column2:data['userid'])
    # end
    # p json
    end
end
