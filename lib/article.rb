class Article < ActiveRecord::Base
  has_many :users, through: :user_articles
  has_many :users
  belongs_to :topic
end
