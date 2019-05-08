class Article < ActiveRecord::Base
  has_many :users, through: :bookmarked_articles
  has_many :users
end
