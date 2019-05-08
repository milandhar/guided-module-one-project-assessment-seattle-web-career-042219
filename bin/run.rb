require_relative '../config/environment'
require_relative '../lib/cli.rb'

cli = CommandLineInterface.new
cli.greeting_prompt
cli.create_user
