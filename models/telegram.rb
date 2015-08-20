class Telegram
	def self.msg(content, recipient)
		return "msg user##{recipient} #{content}"
	end
end