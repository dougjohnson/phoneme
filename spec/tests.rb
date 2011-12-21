require './app'
require 'rspec'
require 'rack/test'

set :environment, :test

ENV['DOUG_MOBILE'] = '+44123456789'
ENV['DOUG_MOBILE_WORK'] = '+44987654321'
ENV['MARCUS_MOBILE'] = '+44555555'
ENV['ED_MOBILE'] = '+44666666'
ENV['KEITH_MOBILE'] = '+4477777'

describe 'The PhoneMe App' do
  include Rack::Test::Methods

  def app
    Sinatra::Application
  end

  it "should respond to a call-back from twilio with valid xml" do
    post '/call-handler', :Called => ENV['DOUG_MOBILE']
    last_response.should be_ok
    last_response.body.should =~ /<\?xml version="1\.0" encoding="UTF-8"\?><Response><Say voice="man" language="en-gb">.+<\/Say><\/Response>/
  end

  it "should create a call for Doug when params[:plain] contains the text 'call doug'" do
    mock_twilio_client = double(Twilio::REST::Client)
    Twilio::REST::Client.stub(:new).and_return(mock_twilio_client)
    mock_twilio_client.stub_chain(:account, :calls).and_return(double('twilio_calls'))
    mock_twilio_client.account.calls.should_receive(:create).with(
      :from => ENV['DOUG_MOBILE_WORK'],
      :to => ENV['DOUG_MOBILE'],
      :url => 'http://phoneme.heroku.com/call-handler'
    )

    post '/', :plain => 'call doug'
    last_response.should be_ok
    
  end
end
