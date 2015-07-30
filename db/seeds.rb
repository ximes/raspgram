# Seed add you the ability to populate your db.
# We provide you a basic shell for interaction with the end user.
# So try some code like below:
#
#   name = shell.ask("What's your name?")
#   shell.say name
#

account = Account.create(:email => "admin@example.com", :name => "First name", :surname => "Last name", :password => "password", :password_confirmation => "password", :role => "admin")