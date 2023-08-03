require 'twilio-ruby'

class SmsService

  ACCOUNT_SID = ENV['TWILIO_ACCOUNT_SID']
  FROM = ENV['TWILIO_PHONE']
  TO = ENV['MY_PHONE']
  TOKEN = ENV['TWILIO_ACCOUNT_TOKEN']

  def initialize(message)
    @message = message
    @client = Twilio::REST::Client.new(ACCOUNT_SID, TOKEN)
  end

  def self.call(message)
    new(message).send
  end

  def send
    @client.messages.create(
      from: FROM,
      to: TO,
      body: @message
    )
  end



end
