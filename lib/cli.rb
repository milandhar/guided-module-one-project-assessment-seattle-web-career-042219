require 'pry'

class CommandLineInterface
    def greet
        puts "Welcome to Felp, the best resource in the world for your New York Times news!"
    end

    # def get_name
    #     puts "Please enter your name: "
    # end

    # def get_user_name
    #     user_name = gets.chomp
    # end

    # def prompt_user
    #     puts "Thinking of reading the newspapaper? We can help you find an article."

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

    def get_user
        greet
        puts "Please enter your name: "
        user_name = gets.chomp
        new_user = User.create(name: user_name)
        binding.pry
    end
end