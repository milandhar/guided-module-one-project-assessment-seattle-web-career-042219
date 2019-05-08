require 'faker'
require 'rest-client'
require 'json'
require 'pry'
require_relative '../lib/cli.rb'


def get_articles_from_api(api_url, chosen_topic = "politics")

    response_string = RestClient.get(api_url)
    response_hash = JSON.parse(response_string)


    article_array = response_hash["results"].map do |article|
        if article["section"] == chosen_topic.capitalize
          article
        end
      end.compact
end


  def upload_articles_to_db(articles, chosen_topic = "Health")
    articles.each do |article|
      Article.create(title: article["title"], published_date: article["published_date"], short_url: article["short_url"], section: article["section"], byline: article["byline"], abstract: article["abstract"])
    end
  end

#
# i = 0
# while i < 5
#   User.create(name: Faker::Name.name)
#   i += 1
# end
#
#
# k = 0
# while k < 10
#   Article.create(title: Faker::Book.title, published_date: Faker::Date.backward(14), short_url: Faker::Internet.url,
#   section: Faker::Book.genre, byline: Faker::Book.author, abstract: Faker::Hipster.sentences(1)[0])
#   k+=1
# end
