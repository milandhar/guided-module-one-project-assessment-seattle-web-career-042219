# NYTimes Bookmark Tool

The NYTimes Bookmark Tool is a CLI application written in Ruby that allows users to interact with the [New York Times Top Stories API](https://developer.nytimes.com/docs/top-stories-product/1/overview). The Tool allows the user to view the most recently published NYTimes stories based on the user's desired section (Homepage, Science, Politics, etc), and gives the user the option to save articles to a bookmark list. You will be able to save time by viewing the top stories of the day in seconds, ad free!


![Alt Text](https://media.giphy.com/media/nZZGtA2C10OXu/giphy.gif)


## Installation

* Make sure you have [Ruby](https://www.ruby-lang.org/en/documentation/installation/) installed.
* Fork and Clone the [repository](https://github.com/milandhar/guided-module-one-project-assessment-seattle-web-career-042219)
* Navigate using `cd` to the folder containing `guided-module-one-project-assessment-seattle-web-career-042219`
* Run `bundle install`
* Create and migrate the tables using `rake db:migrate`
* Start the program: `ruby bin/run.rb`

Optional - To read unlimited articles on the NYTimes, you must [subscribe](https://www.nytimes.com/subscription?campaignId=6W74R&&redirect_uri=https%3A%2F%2Fwww.nytimes.com%2F) to the New York Times. The Times limits non-subscribers to **reading** 5 articles per month. However, you do not have to subscribe to the Times in order to use the full functionality of the NYTimes Bookmark Tool.

## Using the Program

The CLI prompts will walk you through the flow of the Tool. First you will create a new username which you can use in future sessions to log in and access/edit your bookmarks.

You will then be given a numbered list of all possible NYTimes sections. You will be able to select which section you are interested in, and then will see the top-5 most recent articles published under that section.

Next, you will have the option to add any/all of the top-5 articles to your bookmarks, and can view your entire bookmark list. After viewing your bookmarks, you can decide to delete a bookmark from the list if you have already read it or are no longer interested in that article.

## Features

Here are the features included in this version of the NYTimes Bookmark Tool:
* Create a user name
* Login with an existing user name and log out when complete
* Select an NYTimes section to view recent articles
* Bookmark an article
* View your bookmarks
* Open a bookmark url in your default web browser
* Delete a bookmark from your list


## An Inside Look at NYTimes Bookmark Tool


Here is the list of the welcome screen along with the NYTimes sections the user can select:

![Imgur](https://i.imgur.com/aZSWato.png)


Here is an example of a top-5 article result list with a bookmark prompt:

![Imgur](https://i.imgur.com/3JOpySF.png)


Here is a link to a video demo of the Tool:

[![Youtube](https://img.youtube.com/vi/3lnWob63pY4/0.jpg)](https://www.youtube.com/watch?v=3lnWob63pY4)

## Sample Code

**Seeding Articles to DB - Avoiding Duplicates:**
```ruby
def upload_articles_to_db(articles, chosen_topic = "home")
  articles.each do |article|
    if Article.where("short_url = '#{article["short_url"]}'").length == 0
      if chosen_topic == "politics"
        Article.find_or_create_by(title: article["title"], published_date: article["published_date"], short_url: article["short_url"], section: article["subsection"], byline: article["byline"], abstract: article["abstract"])
      else
        Article.find_or_create_by(title: article["title"], published_date: article["published_date"], short_url: article["short_url"], section: article["section"], byline: article["byline"], abstract: article["abstract"])
      end
    end
  end
end
```


**Using Launchy gem to Open Article in Browser:**
```ruby
if open_url == "y"
  print_bookmarks
  print "        Please enter the number of the article you want to open (1-#{User.all.find(@user_id).articles.length}): "
  open_browser = gets.chomp
  puts
  website = User.all.find(@user_id).articles[open_browser.to_i - 1]
  Launchy.open(website.short_url)
  print "        Do you want to open another article? (y/n): "
  open_url = gets.chomp
  puts
else
  loop_open = false
end
```


## Credits
The NYTimes Bookmark Tool was developed by [Milan Dhar](https://github.com/milandhar) and [Vadim Stakhnyuk](https://github.com/VadimS4).

We used the following [Ruby Gems](https://rubygems.org/):
* gem "sinatra-activerecord"
* gem "sqlite3"
* gem "pry"
* gem "require_all"
* gem "rest-client"
* gem "json"
* gem "colorize"
* gem "launchy"
