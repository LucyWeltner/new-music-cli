require_relative "../lib/scraper.rb"

class Song
  attr_accessor :title, :artist, :url
  @@songs = []
  def initialize(title, artist, url)
    @title = title 
    @artist = artist 
    @url = url 
  end

  def self.trim_description
    description = JsonParser.parse_playlist_json
    description_array = description.split("\n")
    first_songs_index = description_array.find_index{|line| line.include?("- ")}
    #to get the index of the last song, reverse the array, find the index of the first song, then multiply that number by -1 (because it's the same distance from the beginning of the reversed array as it is from the end of the original array, ie the second element of the reversed array is the second to last element of the original array)
    last_songs_index = description_array.reverse.find_index{|line| line.include?(" - ")}*-1
    #select and return all the content between the first song and the last song. 
    description_array = description_array[first_songs_index..last_songs_index]
  end
    
  def self.make_songs_from_description
    #make an array of songs. Each song is represented by a smaller array with title and artist elements.
    description = self.trim_description
    song_array = description.select {|line| line.include?(" - ")}
    song_aoa = song_array.map{|title_and_artist| title_and_artist.split(" - ")}
    
    #make an array of urls. Each song should have a matching URL.
    url_array = description.select{|line| line.include?("https://")}
    
    #iterate over song array and create a new song object for each element of the array. 
    song_aoa.each_with_index do |song, index|
      new_song = self.new(song[1],song[0],url_array[index])
      @@songs << new_song
    end
  end
  
  def self.search_by_title(a_title)
    #downcase the song title and input so the search works regardless of capitalization
    self.all.find{|song| song.title.downcase == a_title.downcase}
  end 
  
  def self.search_by_artist(an_artist)
    found = self.all.select{|song| song.artist.downcase == an_artist.downcase}
    #If you only find one song by an artist, return only that song
    if found.length == 1 
      found[0]
    end 
  end 
  
  def self.search 
    puts "Search for a song by typing the title or artist."
    input = gets.chomp!
    if search_by_artist(input)
      results = search_by_artist(input)
      #if there are multiple results, iterate through an array to show each one
      if results.class == Array 
        puts "There are #{results.length} songs that match your query:"
        results.each_with_index do |song, index|
          puts "#{index+1}. #{song.title} by #{song.artist}. Listen at #{song.url}"
        end
      #if there is only one result, show only that result
      else 
        puts "The song that matches your query is #{results.title} by #{results.artist} which you can listen to at #{results.url}."
      end 
    elsif search_by_title(input)
      song = search_by_title(input)
      puts "The song that matches your query is #{song.title} by #{song.artist} which you can listen to at #{song.url}"
    else 
      puts "Sorry, there are no results that match your query. Please check your spelling and try again."
    end 
  end 
  
  def self.all 
    @@songs
  end 
  
  def self.display_all
    puts "Here are all the songs that came out this week."
    self.all.each_with_index do |song, index|
      puts "#{index+1}. #{song.title} by #{song.artist} listen at #{song.url}"
    end
  end
end 

Song.make_songs_from_description
Song.display_all

