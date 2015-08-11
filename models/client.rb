# encoding: utf-8
require 'yaml'
require 'io/console'

class Client
  def self.connect
  	config = (YAML.load_file('config/raspgram.yml')['config']).merge({'daemon' => "bin/telegram-cli", 'sock' => 'tg.sock'})
    IO.popen(["screen", "-ls", :err=>[:child, :out]]) do |ls_io|
	  if /No Sockets found/i.match ls_io.read
		command = "screen -dm -S tgram #{config['lib_path']}#{config['daemon']}  -s ./queue.lua -k #{config['key']}"
		connected = system(command)
	  end
	end
  end

end