require_relative 'lib/film'
require_relative 'lib/film_collection'

current_path = File.dirname(__FILE__)

collection = FilmCollection.from_dir(current_path)

puts collection

user_choise = STDIN.gets.to_i until collection.directors_range.include?(user_choise)

film = collection.find_film(user_choise - 1)
if film
  puts 'И сегодня вечером рекомендую посмотреть:'
  puts film
else
  puts 'Фильм выбранного режиссёра не найден!'
end
