class TelegramBot
  attr_reader :token, :client

  def initialize
    @token = Rails.application.secrets[:token]
    @client = Telegram::Bot::Client.new(@token)
  end

  def update(data)
    update = Telegram::Bot::Types::Update.new(data[:update])
    message = Telegram::Bot::Types::Message.new(data[:message])

    case 
      when matches = message.text.match(/^(dice)(\s([0-9]{1,3})||$)/)
        dice_size = matches.values_at(2).reject(&:blank?).first.to_i
        dice_size = 6 if dice_size == 0

        text = "#{rand(dice_size) + 1}  "
        chat_id = message.chat.id

        client.api.send_message(chat_id: chat_id, text: text)
      when message.text == '/status'
        text = "Message from: #{message.from.first_name} #{message.from.last_name}.\r\n All ok."
        chat_id = message.chat.id

        client.api.send_message(chat_id: chat_id, text: text) 
      else
        chat_id = message.chat.id

        client.api.send_message(chat_id: chat_id, text: 'Received')
    end  
  end
end