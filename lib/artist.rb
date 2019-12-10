class Artist 
  attr_accessor :name 
  def initialize(name)
    @name = name
  end 
  def self.find_or_create(name)
    found = Song.all.find do |song|
      song.artist.name == name
    end 
    if !found 
      self.new(name)
    end
  end
end

