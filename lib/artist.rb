require_relative "./songs.rb"

class Artist 
  attr_accessor :name 
  def initialize(name)
    @name = name
  end 
  def self.find_or_create(name)
    found = false 
    Song.all.each do |song|
      if song.artist.name == name 
        found = song.artist
      end 
    end 
    if found 
      return found 
    else 
      self.new(name)
    end 
  end 
end

Artist.find_or_create("Bill Callahan")
