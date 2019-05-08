require 'pry'

class CommandLineInterface

    # Greeting Prompt

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