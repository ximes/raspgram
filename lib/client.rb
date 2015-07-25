# encoding: utf-8
require 'yaml'
require_relative 'api'

class Client < API
  attr_reader :config
  
  def self.connect(&block)
    @config = (YAML.load_file('config/raspgram.yml')['config']).merge({'daemon' => "bin/telegram-cli", 'sock' => 'tg.sock'})
    @connect_callback = block

    command = "screen -dm -S tgram #{@config['lib_path']}#{@config['daemon']}  -s ./queue.lua -k #{@config['key']}"
    @ok = system( command )
  end
end