require 'pry'
require 'time'
require 'launchy'
require_relative '../db/seeds.rb'


class CommandLineInterface
  attr_accessor :chosen_topic, :user_name, :live
  attr_reader :id, :user_list

  @@article_limit = 5
  @chosen_topic = ""
  @article_array = []
  @user_name = ""
  @user_id = 0
  @user_list = []
  @live = true
  @remove_flag = true

    def initialize
      @live = true
    end

    def greeting_prompt
        system('clear')
        puts
        puts "        Welcome to NYTimes Bookmark Tool
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        The best resource for finding top articles
        based on your favorite topics!"
        puts
        puts "        Before we dwell into the NYTimes,
        enter your username, or if you don't have one,
        press enter to create a new username!
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
        puts
        print "        Username: "
        user_input = gets.chomp

        if user_input == "q"
          quit_program
        end
        if user_input == ""
            create_user
        else
            #binding.pry
            load_user(user_input)
        end
    end

    def create_user
        print "        Create Username: "
        new_name = gets.chomp
        new_user = User.create(name: new_name)
        @user_name = new_name
        @user_id = new_user.id
        puts
        puts "        ````````````````````````````````````````````````````````````````````````````````
        Welcome #{new_name}! Thank you for using the NYTimes Bookmark Tool!
        _______________________________________________________________________________"
        puts
    end

    def load_user(user_input)
        #binding.pry
        if user_input == "q"
          quit_program
        elsif User.find_by(name: user_input) == nil
          puts
          puts "        Incorrect user name!"
          puts
          print "        Would you like to create a new user name? (y/n): "
          user_decision = gets.chomp
          puts
          if user_decision == "y"
            create_user
          elsif user_decision == "n"
            print "        Please enter correct username: "
            user_input = gets.chomp
            load_user(user_input)
            puts
          elsif user_decision == "q"
            end_session
          else
            invalid_command
            load_user(user_input)
          end
        else
          user_input == User.find_by(name: user_input).name
          puts
          puts "        Welcome, #{user_input}! Good to see you back!"
          puts
          @user_name = user_input
          @user_id = User.find_by(name: user_input).id
        end
            #can add while loop here for incorrect responses

      end

    def topic_prompt
      puts
      print "        1. Arts "
      puts "              2. Automobiles"
      print "        3. Books"
      puts "              4. Business"
      print "        5. Fashion"
      puts "            6. Food"
      print "        7. Health"
      puts "             8. Home"
      print "        9. Insider"
      puts "            10. Magazine"
      print "        11. Movies"
      puts "            12. National"
      print "        13. NY Region"
      puts "         14. Obituaries"
      print "        15. Opinion"
      puts "           16. Politics"
      print "        17. Real Estate"
      puts "       18. Science"
      print "        19. Sports"
      puts "            20. Sunday Review"
      print "        21. Technology"
      puts "        22. Theater"
      print "        23. Times Magazine"
      puts "    24. Travel"
      print "        25. Upshot"
      puts "            26. World"
      puts
      print "        Select a Section you would like to read about! (or press 'q' to quit): "

      user_selection = gets.chomp
      puts
      if user_selection == "q"
        quit_program
      end
      @chosen_topic = ""

      case user_selection
      when "1", "1.", "Arts", "arts", "art"
        @chosen_topic = "arts"
      when "2", "2.", "Automobiles", "automobiles", "auto", "Auto"
        @chosen_topic = "automobiles"
      when "3", "3.", "Books", "books", "book", "books"
        @chosen_topic = "books"
      when "4", "4.", "Business", "business", "Businesses", "businesses"
        @chosen_topic = "business"
      when "5", "5.", "Fashion", "fashion"
        @chosen_topic = "fashion"
      when "6", "6.", "Food", "food"
        @chosen_topic = "food"
      when "7", "7.", "health", "Health"
        @chosen_topic = "health"
      when "8", "8.", "home", "Home", "Homepage", "Home Page", "homepage"
        @chosen_topic = "home"
      when "9", "9.", "insider", "Insider"
        @chosen_topic = "insider"
      when "10", "10.", "Magazine", "magazine"
        @chosen_topic = "magazine"
      when "11", "11.", "Movies", "movies"
        @chosen_topic = "movies"
      when "12", "12.", "National", "national"
        @chosen_topic = "national"
      when "13", "13.", "Nyregion", "nyregion"
        @chosen_topic = "nyregion"
      when "14", "14.", "Obituaries", "obituaries"
        @chosen_topic = "obituaries"
      when "15", "15.", "Opinion", "opinion"
        @chosen_topic = "opinion"
      when "16", "16.", "Politics", "politics"
        @chosen_topic = "politics"
      when "17", "17.", "Real Estate", "real estate", "Real estate", "realestate"
        @chosen_topic = "realestate"
      when "18", "18.", "Science", "science"
        @chosen_topic = "science"
      when "19", "19.", "Sports", "sports"
        @chosen_topic = "sports"
      when "20", "20.", "Sunday Review", "sunday review", "Sunday", "sunday"
        @chosen_topic = "sundayreview"
      when "21", "21.", "technology", "Technology", "tech", "Tech"
        @chosen_topic = "technology"
      when "22", "22.", "theater", "Theater"
        @chosen_topic = "theater"
      when "23", "23.", "tmagazine", "Tmagazine", "Times Magazine", "times magazine"
        @chosen_topic = "tmagazine"
      when "24", "24.", "travel", "Travel"
        @chosen_topic = "travel"
      when "25", "25.", "upshot", "Upshot"
        @chosen_topic = "upshot"
      when "26", "26.", "world", "World"
        @chosen_topic = "world"
      when "Q", "q.", "q", "Q."
        @chosen_topic = "quit"
      else
        @chosen_topic = "error"
      end
    end

    def interpolate_url_and_seed_db(chosen_topic)
      api_url = ""
      if @chosen_topic == "error"
        invalid_command
        topic_prompt
      elsif @chosen_topic == "quit"
        end_session
      else
        api_url = "https://api.nytimes.com/svc/topstories/v2/#{chosen_topic}.json?api-key=WIEQBVb7KEpNBQMvXKMGJYSbf0FdgbYo"
        upload_articles_to_db(get_articles_from_api(api_url, @chosen_topic), @chosen_topic)
      end
    end

    def print_articles
      i = 1

      if @chosen_topic == "national"
          corrected_topic = "U.S."
          @user_list =  Article.where(section: "U.S.").order('published_date desc').limit(@@article_limit)
      else
          @user_list =  Article.where(section: @chosen_topic.capitalize).order('published_date desc').limit(@@article_limit)
      end

      @user_list.each do |article|

            paragraph = article.abstract[0..90] + "..."
            article_description = <<~ARTICLE_DESCRIPTION

            #{i}.   #{article.title.colorize(:light_green)}

                    #{article.byline} 

                    #{paragraph}

                    #{article.short_url}

                    Published: #{Time.parse(article.published_date)}


            ARTICLE_DESCRIPTION
            i += 1
            puts article_description
      end
      if @user_list.length == 0
        puts "        Sorry, there are no recent articles in that section"
      else
        @user_list
      end
    end

    def add_topic_to_favorites
      response = "y"

      print "        Would you like to add an article to your Bookmarks? (y/n): "

        while response == "y"
          response = gets.chomp
        puts
          if response == "y"
        print "        Select article to add to Bookmarks (1-#{@user_list.length}): "
        desired_article = gets.chomp
            if (1..(@user_list.length)).to_a.include?(desired_article.to_i) == false
              puts "        Please enter a valid number (1-#{@user_list.length})"
              desired_article = gets.chomp

              puts "\"#{@user_list[desired_article.to_i - 1].title}\" has been added to your Bookmarks!"
              puts
              print "        Would you like to add another article to your Bookmarks? (y/n): "
            else
            BookmarkedArticle.create(user_id: @user_id, article_id: @user_list[desired_article.to_i - 1].id)
              puts
              puts "        #{@user_list[desired_article.to_i - 1].title} has been added to your Bookmarks!"
              puts
              print "        Would you like to add another article to your Bookmarks? (y/n): "
            end
        elsif response == "n"
          response = "n"
        elsif response == "q"
          quit_program
        else
          invalid_command
          response = "y"
        end
      end
    end

    def view_bookmarks
      print "        Do you want to view your your list of Bookmarked articles? (y/n): "

      view_bookmarks = gets.chomp
      puts
       if view_bookmarks == "y"
        print_bookmarks
      elsif view_bookmarks == "n"
        return
      else
        "        Invalid Command!"
        view_bookmarks
      end
    end


    def print_bookmarks
      j = 1
      puts "
      BOOKMARKS
      _________________________________________________________"
   
        User.all.find(@user_id).articles.each do |bookmarked_article|
            bookmark = Article.find(bookmarked_article.id)

            paragraph = (bookmark.abstract[0..90] + "...")
            @url = bookmark.short_url

            puts "#{j}.   #{bookmark.title.colorize(:light_green)}"
            puts
            puts "        #{bookmark.byline}"
            puts
            puts "        #{paragraph}"
            puts
            puts "        #{(bookmark.short_url)}"
            puts
            j += 1
        end

      end

    end

    def open_website
      print "        Do you want to open an article in your web browser? (y/n): "
      open_url = gets.chomp
      puts
      if open_url == "y"
        print "        Please enter the number from the article you want to open: "
        open_browser = gets.chomp
        puts
        website = User.all.find(@user_id).articles[open_browser.to_i - 1]
        Launchy.open(website.short_url)
      end
    end

    def remove_article_from_bookmarks

      while @remove_flag = true
        print "        Do you want to remove an article from your Bookmarks? (y/n): "
        user_answer = gets.chomp
        puts
        if user_answer == "y"
          print "        Please enter the number of the article you want to remove: (1-#{User.all.find(@user_id).articles.length}): "
          delete_number = gets.chomp
          puts
          delete_article = User.all.find(@user_id).articles[delete_number.to_i - 1]
          delete_bookmark = BookmarkedArticle.find_by(user_id: @user_id, article_id: delete_article.id)
          BookmarkedArticle.destroy(delete_bookmark.id)
          puts "        \"#{delete_article.title}\" has been removed from your Bookmarks!"
          puts
          if User.all.find(@user_id).articles.length > 0
            print "         Would you like to remove another article from your Bookmarks? (y/n) "
            another_removal = gets.chomp
            puts
            if another_removal == 'y'
              remove_article_from_bookmarks
            else
              @remove_flag = false
              return
            end
            return
          end
        else
            @remove_flag = false
            return
          end
        end
    end

    def invalid_command
      puts "        Invalid Command. Please try again or press q to quit: "
    end

    def quit_program
      puts
      puts "      ``````````````````````````````````````````````````````
      Goodbye! Thank you for using NYTimes Bookmark Tool :)
      ......................................................"
      puts
      abort
    end

    def end_session
        puts "        Good Bye"
        abort
    end

    def view_another_section_prompt
      print "        Would you like to view another section? (y/n): "
      repeat_response = gets.chomp
      puts
      if repeat_response == "y"
        @live = true
      else
        @live = false
      end
  end
end
