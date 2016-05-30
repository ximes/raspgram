class TelegramBot
  attr_reader :token, :client
  attr_reader :message

  include Tricks

  def initialize
    @token = Rails.application.secrets[:token]
    @client = Telegram::Bot::Client.new(@token)
  end

  def update(data)
    update = Telegram::Bot::Types::Update.new(data)
    @message = extract_message(update)

    question = 'What would you like me to do?'

    case @message
      when Telegram::Bot::Types::CallbackQuery
        if @message.data == 'cancel'
          hide_keyboard
          send_message(text: "ok. #{question}")
        end
        
        parse_callback_queries

      when Telegram::Bot::Types::Message
        if @message.text == '/help'
          markup = Telegram::Bot::Types::InlineKeyboardMarkup.new(inline_keyboard: trick_commands)
          @client.api.send_message(text: question, reply_markup: markup, chat_id: @message.chat.id)
        else

        end

      else
    end  
  end

  def send_message(opt)
    @client.api.send_message({chat_id: @message.from.id}.merge(opt))
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