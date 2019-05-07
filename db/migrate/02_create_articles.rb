class CreateArticles < ActiveRecord::Migration[5.2]
  def change
    create_table :articles do |t|
      t.string :title
      t.string :published_date
      t.string :short_url
      t.string :section
      t.string :byline
      t.string :abstract
    end
  end
end
