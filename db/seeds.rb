require 'faker'
require 'rest-client'
require 'json'
require 'pry'

def get_articles_from_api(user_section = "Health")


    response_string = RestClient.get('https://api.nytimes.com/svc/topstories/v2/health.json?api-key=WIEQBVb7KEpNBQMvXKMGJYSbf0FdgbYo')
    response_hash = JSON.parse(response_string)
    article_array = []

    article_array = response_hash["results"].map do |article|
        if article["section"] == "Health"
          article
        end
      end.compact
end


  def upload_articles_to_db(user_section = "Health")
    get_articles_from_api(user_section).each do |article|
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
