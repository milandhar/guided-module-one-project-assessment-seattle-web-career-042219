require 'faker'

i = 0
while i < 5
  User.create(name: Faker::Name.name)
  i += 1
end


k = 0
while k < 10
  Article.create(title: Faker::Book.title, published_date: Faker::Date.backward(14), short_url: Faker::Internet.url,
  section: Faker::Book.genre, byline: Faker::Book.author, abstract: Faker::Hipster.sentences(1)[0])
  k+=1
end
