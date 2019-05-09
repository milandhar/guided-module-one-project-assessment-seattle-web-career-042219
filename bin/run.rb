require_relative '../config/environment'
require_relative '../lib/cli.rb'
require_relative '../db/seeds.rb'

cli = CommandLineInterface.new

cli.greeting_prompt
cli.topic_prompt
cli.interpolate_url_and_seed_db(cli.chosen_topic)
cli.print_articles
if cli.user_list.length > 0
  cli.add_topic_to_favorites
end
cli.view_and_edit_bookmarks
