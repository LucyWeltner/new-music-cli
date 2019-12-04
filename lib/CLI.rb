require_relative "./songs.rb"
require_relative "./scraper.rb"
require_relative "../bin/console"
require_relative "..bin/setup"
class CLI_interface 
  def self.start 
    puts "Welcome! To see a list of songs released this week, write display. To search for a specific song or artist who released a song this week, write search."
    input = gets.chomp!.downcase
    if input == "display"
      Song.display_all 
    elsif input == "search"
      Song.search 
    else 
      while input != "display" && input != "search"
        puts "Please type display or search."
        input = gets.chomp!
      end 
    end 
  end 