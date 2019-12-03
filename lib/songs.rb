require_relative "../lib/scraper.rb"
class Song
  attr_accessor :title, :artist, :url
  @@description = []
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
    #select all the content between the first song and the last song. Put that content into the description class variable.
    @@description << description_array[first_songs_index..last_songs_index]
    @@description = @@description.flatten
  end
    
  def self.make_songs_from_description
    #make an array of songs. Each song is represented by a smaller array with title and artist elements.
    self.trim_description
    song_array = @@description.select {|line| line.include?(" - ")}
    song_aoa = song_array.map{|title_and_artist| title_and_artist.split(" - ")}
    
    #make an array of urls. Each song should have a matching URL.
    url_array = @@description.select{|line| line.include?("https://")}
    
    #iterate over song array and create a new song object for each element of the array. 
    song_aoa.each_with_index do |song, index|
      new_song = self.new(song[1],song[0],url_array[index])
      @@songs << new_song
    end
  end
  
  def self.search_by_title(a_title)
    @@songs.find{|song| song.title == a_title}
  end 
  
  def self.search_by_artist(an_artist)
    found = @@songs.select{|song| song.artist == an_artist
    #If you only find one song by an artist, return only that song
    if found.length == 1 
      found.length[0]
    end 
  end 
  
  def self.search 
    puts "You can search for a song by typing the title or artist."
    input = gets.chomp!
    if search_by_artist(input) 
      results = search_by_artist(input)
      if results.class == Array 
        puts "There are #{results.length} songs that match your query:"
        results.each_with_index do |song, index|
          puts "#{index+1}. #{song.title} by #{song.artist}. Listen at #{song.url}"
      else 
        puts "The song that matches your query is #{song.title} by #{song.artist} which you can listen to at #{song.url}."
      end 
    elsif search_by_title(input)
      puts "The song that matches your query is #{song.title} by #{song.artist} which you can listen to at #{song.url}"
    else 
      puts "Sorry, there are no results that match your query. Please check your spelling and try again."
    end 
  end 
  
  def self.all_songs 
    @@songs 
  end 
end 

Song.make_songs_from_description
Song.all_songs

