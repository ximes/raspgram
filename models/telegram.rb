class Telegram
	def self.msg(content, recipient)
		return "msg user#" + recipient.to_s + ' "' + content.to_s + '"'
	end
	def self.mark_read(recipient)
		return "mark_read user##{recipient}"
	end
	def self.send_picture(img, recipient)
		return "send_photo user##{recipient} '#{img}'"
	end
end