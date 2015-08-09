RACK_ENV = 'test' unless defined?(RACK_ENV)
require File.expand_path(File.dirname(__FILE__) + "/../config/boot")

Dir[File.expand_path(File.dirname(__FILE__) + "/../app/helpers/**/*.rb")].each(&method(:require))

RSpec.configure do |conf|
  conf.include Rack::Test::Methods
  conf.include RSpecHtmlMatchers
  conf.mock_with :mocha
  conf.include FactoryGirl::Syntax::Methods
  conf.before(:suite) do
    begin
      DatabaseCleaner.start
    ensure
      DatabaseCleaner.clean
    end
  end
end

# You can use this method to custom specify a Rack app
# you want rack-test to invoke:
#
#   app Raspgram::App
#   app Raspgram::App.tap { |a| }
#   app(Raspgram::App) do
#     set :foo, :bar
#   end
#
def app(app = nil, &blk)
  @app ||= block_given? ? app.instance_eval(&blk) : app
  @app ||= Padrino.application
end

def load_settings
  Raspgram::App.settings
  Raspgram::App.settings.stubs(:admin_email).returns("test@example.com")
end

FactoryGirl.definition_file_paths = [
    File.join(Padrino.root, 'factories'),
    File.join(Padrino.root, 'spec', 'factories')
]
FactoryGirl.find_definitions