require 'sinatra'
require 'builder'
require 'twilio-ruby'

account_sid = 'AC773b9ae797d841da8cf4a6d7e0e4f0fe'
auth_token = 'bfbb4e65cf5fb819ed53fb36ab6b80a9'

post '/call-handler' do
  logger.info params
  response = Twilio::TwiML::Response.new do |r|
    r.Say 'Hello, Marcus. You are very very gay.', :voice => 'man', :language => 'en-gb'
    r.Say 'No, Marcus is lovely. And I assure you he is definitely not a homosexual.', :voice => 'woman'
    r.Say 'Who the hell are you?', :voice => 'man', :language => 'en-gb'
    r.Say 'I am his teddy bear. Didn\'t you know I\'m a girl?', :voice => 'woman'
  end
  return response.text
end

post '/' do
  if params[:plain] =~ /call doug/i
    @client = Twilio::REST::Client.new account_sid, auth_token
    @call = @client.account.calls.create(
      :from => '+447973157563',
      :to => '+447879624700',
      :url => 'http://phoneme.heroku.com/call-handler'
    )
  end

  if params[:plain] =~ /call marcus/i
    @client = Twilio::REST::Client.new account_sid, auth_token
    @call = @client.account.calls.create(
      :from => '+447973157563',
      :to => '+447879624700',
      :url => 'http://phoneme.heroku.com/call-handler'
    )
    @call = @client.account.calls.create(
      :from => '+447973157563',
      :to => '+447977100812',
      :url => 'http://phoneme.heroku.com/call-handler'
    )
  end
end
