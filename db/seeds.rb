# This file should ensure the existence of records required to run the application in every environment (production,
# development, test). The code here should be idempotent so that it can be executed at any point in every environment.
# The data can then be loaded with the bin/rails db:seed command (or created alongside the database with db:setup).
#
# Example:
#
#   ["Action", "Comedy", "Drama", "Horror"].each do |genre_name|
#     MovieGenre.find_or_create_by!(name: genre_name)
#   end

require 'json'
require 'open-uri'

url = "https://tmdb.lewagon.com/movie/top_rated"
movies_serialized = URI.parse(url).read
movies = JSON.parse(movies_serialized)

movies["results"].each do |m|
  pp m["title"]
  Movie.create(
    title: m["title"],
    overview: m["overview"],
    poster_url: m["poster_path"],
    rating: m["vote_average"]
  )
end
