class User < ActiveRecord::Base
  has_many :bookmarked_articles
  has_many :articles, through: :bookmarked_articles
end
