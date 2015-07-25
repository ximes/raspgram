APP_PATH = File.dirname(__FILE__)

require 'sinatra'
require "sinatra/reloader" if development?
require 'json'
require "./lib/api"
require "./lib/client"

enable :sessions

set :root, APP_PATH

class App < Sinatra::Base
	configure :development do
		register Sinatra::Reloader
	end
end


get '/' do
  	if params[:msg]
	  	message = Message.new(params[:msg], params[:user]).parse
	  	{:msg => params[:msg]}.to_json
	  	Response.send(message)
  	end  	
end
get '/connect' do
  	Client::connect
end


class Response
	def self.send(command = false)
		system("screen -r tgram -p 0 -X stuff \"#{command} $(printf \\\r)\"")
	end
end

class Message
	@text
	@from_user
	@to_user

	def initialize(text = "", user = "")
		@text = text.strip
		@from_user = user
	end

	def empty_answer
	end

	def send_status
		send_text "all ok."
	end

	def send_help
		send_text "You can write me:"
		sleep(5)
		send_text "Status (ask me how I am)"
		send_text "Dice (roll a 1d6)"
		send_text "Pic (ask me to take a picture)"
		send_text "Turn screen off (ask me to disable screen output)"
		send_text "Turn screen on (ask me to enable screen output)"
		#send_text "\*Reboot (ask me to reboot. Not working now actually)"
	end
	
	def send_dice
		send_text "#{1+rand(6)}"
	end

	def turnOffScreen
		#activate screensaver
		sendCommandToDisplay "xscreensaver-command -activate"
		#or manually
		#sendCommand "echo 1 | sudo tee /sys/class/backlight/*/bl_power"
	end

	def turnOnScreen
		#activate screensaver
		sendCommandToDisplay "xscreensaver-command -deactivate"
		#or manually
		#sendCommand "echo 0 | sudo tee /sys/class/backlight/*/bl_power"
	end

	def send_text(message)
		sleep(1)
		empty = false
		Response.send "msg user##{@from_user} #{message}"
	end

	def sendCommand(command)
		system(command)
	end	

	def sendCommandToDisplay(command)
		system("DISPLAY=:0 #{command}")
	end	

	def send_photo
		send_text "try this one:"
		img = "#{APP_PATH}/statuses/shot_#{Time.now.to_i}.png"
		sendCommand("raspistill -v -w 500 -h 350 -q 75 -o #{img}")
		Response.send "send_photo user##{@from_user} '#{img}'"
		
		turnOnScreen		
		sendCommandToDisplay("midori #{img} &")
		sendCommand("midori -e fullscreen")

		send_text "do you like it?"
	end

	def reboot
		send_text "I'm rebooting. Now."
		sendCommand("sudo reboot")
	end
	
	def powerOff
		send_text "I'm shutting down. Now."
		sendCommand("sudo poweroff")
	end

	def parse
		Response.send "mark_read user##{@from_user}"
		case @text
			when /^status$/i
			  send_status
			when /^tasks$/i
			  find_tasks
			when /^help$/i
			  send_help
			when /^dice$/i
			  send_dice
			when /^pic$/i
			  send_photo
			when /^turn screen on$/i
			  turnOnScreen
			when /^turn screen off$/i
			  turnOffScreen
		  	when /^*on$/i
			  turnOnScreen
			when /^*off$/i
			  turnOffScreen
		  	when /^\*reboot$/i
			  reboot
		  	when /^\*poweroff$/i
			  powerOff
			else
			  empty_answer
		end
	end
end