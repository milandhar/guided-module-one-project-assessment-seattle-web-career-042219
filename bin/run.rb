require_relative '../config/environment'
require_relative '../lib/cli.rb'

cli = CommandLineInterface.new
cli.greet
cli.get_user
cli.topic_prompt
