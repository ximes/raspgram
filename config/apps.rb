##
# This file mounts each app in the Padrino project to a specified sub-uri.
# You can mount additional applications using any of these commands below:
#
#   Padrino.mount('blog').to('/blog')
#   Padrino.mount('blog', :app_class => 'BlogApp').to('/blog')
#   Padrino.mount('blog', :app_file =>  'path/to/blog/app.rb').to('/blog')
#
# You can also map apps to a specified host:
#
#   Padrino.mount('Admin').host('admin.example.org')
#   Padrino.mount('WebSite').host(/.*\.?example.org/)
#   Padrino.mount('Foo').to('/foo').host('bar.example.org')
#
# Note 1: Mounted apps (by default) should be placed into the project root at '/app_name'.
# Note 2: If you use the host matching remember to respect the order of the rules.
#
# By default, this file mounts the primary app which was generated with this project.
# However, the mounted app can be modified as needed:
#
#   Padrino.mount('AppName', :app_file => 'path/to/file', :app_class => 'BlogApp').to('/')
#

##
# Setup global project settings for your apps. These settings are inherited by every subapp. You can
# override these settings in the subapps as needed.
#
Padrino.configure_apps do
  # enable :sessions
  set :session_secret, '21e3b7af086ed47852c3078522c8cfbe60b08c4d139d86320a842f7fea5e8ee5'
  set :protection, :except => :path_traversal
  set :protect_from_csrf, true

  (YAML.load_file('config/raspgram.yml')['config']).merge({'daemon' => "bin/telegram-cli", 'sock' => 'tg.sock'}).each do |key, config|
	set key.to_s, config
  end 
end

# Mounts the core application for this project

Padrino.mount("Raspgram::Admin", :app_file => Padrino.root('admin/app.rb')).to("/admin")
Padrino.mount('Raspgram::Api', :app_file => Padrino.root('api/app.rb')).to('/api')
Padrino.mount('Raspgram::App', :app_file => Padrino.root('app/app.rb')).to('/')
