require_relative "./songs.rb"
require_relative "./scraper.rb"

class CLI_interface 
  def self.start 
    puts "Welcome! To see a list of songs released this week, write display. To search for a specific song or artist who released a song this week, write search."
    input = gets.chomp!
    input = input.downcase
    until input == "display" || input == "search" do
      puts "Please type display or search."
      input = gets.chomp!
    end 
    if input == "display"
      Song.display_all 
    elsif input == "search"
      Song.search 
    end 
  end 
end

CLI_interface.start