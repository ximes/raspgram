class Telegram
	def self.msg(content, recipient)
		return "msg user##{recipient} #{content}"
	end
	def self.mark_read(recipient)
		return "mark_read user##{recipient}"
	end
end