require 'sinatra'
require 'builder'

get '/' do
  "Hello"
end

post '/' do
  builder do |xml|
    xml.instruct!
    xml.Response do 
      xml.Say("Hello from my Heroku app")
    end
  end
end
