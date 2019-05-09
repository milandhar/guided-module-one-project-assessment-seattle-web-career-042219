require_relative '../config/environment'
require_relative '../lib/cli.rb'
require_relative '../db/seeds.rb'
require 'pry'
require 'word_wrap'

cli = CommandLineInterface.new

#binding.pry

  cli.greeting_prompt

while cli.live == true
  cli.topic_prompt
  cli.interpolate_url_and_seed_db(cli.chosen_topic)
  cli.print_articles
  if cli.user_list.length > 0
    cli.add_topic_to_favorites
  end
  cli.view_bookmarks
  cli.open_website

  cli.remove_article_from_bookmarks
  cli.view_another_section_prompt
end
  cli.quit_program
