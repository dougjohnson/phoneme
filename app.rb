require 'sinatra'
require 'builder'
require 'twilio-ruby'

numbers = {ENV['DOUG_MOBILE'] => 'Doug',
           ENV['MARCUS_MOBILE'] => 'Marcus',
           ENV['ED_MOBILE'] => 'Ed',
           ENV['KEITH_MOBILE'] => 'Keith'}


post '/call-handler' do
  logger.info params
  response = Twilio::TwiML::Response.new do |r|
    r.Say 'Hello, '+numbers[params['Called']]+'. The Sage One application has stopped responding. This phone call has been triggered as a result of ping dom being unable to contact the site for three consecutive minutes. Goodbye!', :voice => 'man', :language => 'en-gb'
  end
  return response.text
end

post '/' do
  numbers.each do |number, name|
    if params[:plain] =~ /call #{name}/i
      @client = Twilio::REST::Client.new ENV['TWILIO_ACCOUNT_SID'], ENV['TWILIO_AUTH_TOKEN']
      @call = @client.account.calls.create(
        :from => ENV['DOUG_MOBILE_WORK'],
        :to => number,
        :url => 'http://phoneme.heroku.com/call-handler'
      )
    end
  end
end

get '/' do
  "here there be dragons..."
end
