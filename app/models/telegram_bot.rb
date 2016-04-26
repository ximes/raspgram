class TelegramBot
  attr_reader :token, :client
  attr_reader :message

  include Gestures

  def initialize
    @token = Rails.application.secrets[:token]
    @client = Telegram::Bot::Client.new(@token)
  end

  def update(data)
    update = Telegram::Bot::Types::Update.new(data)
    @message = extract_message(update)

    case @message
      when Telegram::Bot::Types::CallbackQuery
        if @message.data == 'cancel'
          hide_keyboard
          send_message(text: "ok")
        end

        Gestures.included_modules.each do |included_module|
          a = included_module::Internal.init(self)
          a.call
        end
      when Telegram::Bot::Types::Message
        if @message.text == '/help'
          question = 'What would you like me to do?'
          kb = [
            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Dice', callback_data: 'dice'),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Lights', callback_data: 'light'),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Status', callback_data: 'status'),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Refuse', callback_data: 'refuse'),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Transport', callback_data: 'transport'),
            Telegram::Bot::Types::InlineKeyboardButton.new(text: 'Cancel', callback_data: 'cancel')
          ]
          markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: kb)
          client.api.send_message(text: question, reply_markup: markup)
        else

        end

      else
    end  
  end

  def send_message(opt)
    client.api.send_message({chat_id: @message.from.id}.merge(opt))
  end

  private

  def hide_keyboard
      Telegram::Bot::Types::ReplyKeyboardHide.new(hide_keyboard: true)
  end

  def extract_message(update)
      update.inline_query ||
      update.chosen_inline_result ||
      update.callback_query ||
      update.message
  end
end