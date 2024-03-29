require "json"
require "open-uri"
require "dot env"

class JsonParser
  API_KEY = ENV["API"]
  def self.parse_playlist_json
    json = open("https://www.googleapis.com/youtube/v3/playlistItems?playlistId=PLP4CSgl7K7or84AAhr7zlLNpghEnKWu2c&part=contentDetails&key=" + API_KEY).read
    json = JSON.parse(json)
    self.get_description(json["items"][0]["contentDetails"]["videoId"])
  end
  def self.get_description(video_id)
    json = open("https://www.googleapis.com/youtube/v3/videos?id=#{video_id}&part=snippet&key=" + API_KEY).read
    json = JSON.parse(json)
    description = json["items"][0]["snippet"]["description"]
    description
  end
end
#.env file
 #gem name = dot env   