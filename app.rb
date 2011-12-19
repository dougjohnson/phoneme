require 'sinatra'
require 'builder'

get '/' do
  "Hello"
end

post '/' do

  logger.info 'Here is the body:' + params['plain']
end
