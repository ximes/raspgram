# encoding: utf-8
require 'yaml'
require 'io/console'

class Client
  attr :config
  attr_reader :connected
  
  def initialize
  	connected = false
  	@config = (YAML.load_file('config/raspgram.yml')['config']).merge({'daemon' => "bin/telegram-cli", 'sock' => 'tg.sock'})
  	connect!
  end
  
  private 
  def connect!
    IO.popen(["screen", "-ls", :err=>[:child, :out]]) do |ls_io|
	  if /No Sockets found/i.match ls_io.read
		command = "screen -dmS tgram #{@config['lib_path']}#{@config['daemon']}  -s ./queue.lua -k #{@config['key']}"
		connected = system(command)
	  end
	end
  end

end