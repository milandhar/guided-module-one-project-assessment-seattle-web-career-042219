require 'pry'

class CommandLineInterface

    # Greeting Prompt


    #     puts "Enter a topic you'd like to read about: "
    # end

    # def get_input
    #     topic = gets.chomp
    # end

    def run
        greet
        puts "Enter a topic youd like to read about:"
        topic = gets.chomp
        article = Article.all.find_by(section: topic)
    end

    def topic_prompt
      puts "Please Select a Section: (q to quit)"
      puts "1. Arts"
      puts "2. Automobiles"
      puts "3. Books"
      puts "4. Business"
      puts "5. Fashion"
      puts "6. Food"
      puts "7. Health"
      puts "8. Home"
      puts "9. Insider"
      puts "10. Magazine"
      puts "11. Movies"
      puts "12. National"
      puts "13. NY Region"
      puts "14. Obituaries"
      puts "15. Opinion"
      puts "16. Politics"
      puts "17. Real Estate"
      puts "18. Science"
      puts "19. Sports"
      puts "20. Sunday Review"
      puts "21. Technology"
      puts "22. Theater"
      puts "23. Times Magazine"
      puts "24. Travel"
      puts "25. Upshot"
      puts "26. World"

      user_selection = gets.chomp
      chosen_topic = ""

      case user_selection
      when "1", "1.", "Arts", "arts", "art"
        chosen_topic = "arts"
      when "2", "2.", "Automobiles", "automobiles", "auto", "Auto"
        chosen_topic = "automobiles"
      when "3", "3.", "Books", "books", "book", "books"
        chosen_topic = "books"
      when "4", "4.", "Business", "business", "Businesses", "businesses"
        chosen_topic = "business"
      when "5", "5.", "Fashion", "fashion"
        chosen_topic = "fashion"
      when "6", "6.", "Food", "food"
        chosen_topic = "food"
      when "7", "7.", "health", "Health"
        chosen_topic = "health"
      when "8", "8.", "home", "Home", "Homepage", "Home Page", "homepage"
        chosen_topic = "home"
      when "9", "9.", "insider", "Insider"
        chosen_topic = "insider"
      when "10", "10.", "Magazine", "magazine"
        chosen_topic = "magazine"
      when "11", "11.", "Movies", "movies"
        chosen_topic = "movies"
      when "12", "12.", "National", "national"
        chosen_topic = "national"
      when "13", "13.", "Nyregion", "nyregion"
        chosen_topic = "nyregion"
      when "14", "14.", "Obituaries", "obituaries"
        chosen_topic = "obituaries"
      when "15", "15.", "Opinion", "opinion"
        chosen_topic = "opinion"
      when "16", "16.", "Politics", "politics"
        chosen_topic = "politics"
      when "17", "17.", "Real Estate", "real estate", "Real estate", "realestate"
        chosen_topic = "realestate"
      when "18", "18.", "Science", "science"
        chosen_topic = "science"
      when "19", "19.", "Sports", "sports"
        chosen_topic = "sports"
      when "20", "20.", "Sunday Review", "sunday review", "Sunday", "sunday"
        chosen_topic = "sundayreview"
      when "21", "21.", "technology", "Technology", "tech", "Tech"
        chosen_topic = "technology"
      when "22", "22.", "theater", "Theater"
        chosen_topic = "theater"
      when "23", "23.", "tmagazine", "Tmagazine", "Times Magazine", "times magazine"
        chosen_topic = "tmagazine"
      when "24", "24.", "travel", "Travel"
        chosen_topic = "travel"
      when "25", "25.", "upshot", "Upshot"
        chosen_topic = "upshot"
      when "26", "26.", "world", "World"
        chosen_topic = "world"
      when "Q", "q.", "q", "Q."
        chosen_topic = "quit"
      else
        chosen_topic = "error"
      end

      interpolate_url(chosen_topic)

      #binding.pry

    end

    def invalid_command
      puts "Please try again or press q to quit"
    end

    def interpolate_url(chosen_topic)
      api_url = ""
      if chosen_topic == "error"
        invalid_command
        topic_prompt
      elsif chosen_topic == "quit"
        end_session
      else
        api_url = "https://api.nytimes.com/svc/topstories/v2/.#{chosen_topic}json?api-key=WIEQBVb7KEpNBQMvXKMGJYSbf0FdgbYo"
        binding.pry
      end

    end

    def end_session
        puts "Good Bye"
        return
    end


    def get_user
        puts "Please enter your name: "
        user_name = gets.chomp
        new_user = User.create(name: user_name)

    def greeting_prompt
        system('clear')
        puts
        puts "        Welcome to NYTimes Bookmark Tool
        ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
        The best resource for finding top articles
        based on your favorite topics!"
        puts
    end
    
    def create_user
        puts "        Before we dwell into the NYTimes,
        create a new Username!"
        puts
        print "Create Username: "
        username = gets.chomp
        new_user = User.new(name: username)

    end
end
