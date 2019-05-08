require 'pry'
require_relative '../db/seeds.rb'

class CommandLineInterface
  attr_accessor :chosen_topic, :user_name

  @chosen_topic = ""
  @article_array = []
  @user_name = ""

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
        press enter to create a new username!"
        puts
        print "        username: "
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

    # def create_or_load_user
    #     print "Create Username: "
    #     user_name = gets.chomp
    #     if user_name == ""
    #         print "Enter Username: "
    #         user = gets.chomp
    #         load_user(user)
    #     else
    #         create_user(user_name)
    #     end
    # end

    def create_user
        print "Create Username: "
        new_name = gets.chomp
        new_user = User.create(name: new_name)
        @user_name = new_name
    end

    def load_user(user_input)
        #binding.pry
        if user_input == "q"
          quit_program
        elsif User.find_by(name: user_input) == nil
          puts "        Incorrect user name!"
          puts "        Would you like to create a new user name? (y/n)"
          user_decision = gets.chomp
          if user_decision == "y"
            create_user
          elsif user_decision == "n"
            print "        Please enter correct username: "
            user_input = gets.chomp
            load_user(user_input)
          end
        else
          user_input == User.find_by(name: user_input).name
          puts
          puts "        Welcome, #{user_input}! Good to see you back!"
          puts
          @user_name = user_input
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

    # def get_topic
    #     print "        Enter a Section you would like to read about (or press 'q' to quit): "
    #     topic = gets.chomp
    #     article = Article.all.find_by(section: topic)
    #     interpolate_url_and_seed_db
    # end

    def add_topic_to_favorites

    end

    def invalid_command
      puts "        Please try again or press q to quit"
    end

    def quit_program
      puts
      puts "        Goodbye! Thank you for using NYTimes Bookmark Tool :)"
      puts
      abort
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
        # binding.pry
        upload_articles_to_db(get_articles_from_api(api_url, @chosen_topic), @chosen_topic)

      end
    end

    def end_session
        puts "        Good Bye"
        return
    end
end