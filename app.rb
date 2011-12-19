require 'sinatra'
require 'builder'
require 'twilio-ruby'

account_sid = 'AC773b9ae797d841da8cf4a6d7e0e4f0fe'
auth_token = 'bfbb4e65cf5fb819ed53fb36ab6b80a9'

numbers = {'+447879624700' => 'Doug',
           '+447977100812' => 'Marcus'}


post '/call-handler' do
  logger.info params
  response = Twilio::TwiML::Response.new do |r|
    r.Say 'Hello, '+numbers[params['Called']]+'. You are very very gay.', :voice => 'man', :language => 'en-gb'
  end
  return response.text
end

post '/' do

  numbers.each do |number, name|
    if params[:plain] =~ /call #{name}/i
      @client = Twilio::REST::Client.new account_sid, auth_token
      @call = @client.account.calls.create(
        :from => '+447973157563',
        :to => number,
        :url => 'http://phoneme.heroku.com/call-handler'
      )
    end
  end

  if params[:plain] =~ /call marcus/i
    @client = Twilio::REST::Client.new account_sid, auth_token
    @call = @client.account.calls.create(
      :from => '+447973157563',
      :to => '+447879624700',
      :url => 'http://phoneme.heroku.com/call-handler'
    )
  end
end
