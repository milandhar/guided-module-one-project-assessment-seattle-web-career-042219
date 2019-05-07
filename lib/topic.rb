class Topic < ActiveRecord::Base
  has_many :articles 
end
