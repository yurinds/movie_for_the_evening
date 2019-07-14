require_relative 'lib/film'
require_relative 'lib/film_collection'
require 'nokogiri'
require 'open-uri'

puts 'Откуда берём фильмы: '
puts '1. Локальное хранилище;'
puts '2. Первая страница топ 500 сайта Кинопоиск;'
puts '0. Выход.'

user_input = STDIN.gets.to_i until (0..2).cover?(user_input)

if user_input == 0
  abort 'Программа завершена!'
elsif user_input == 1
  current_path = File.dirname(__FILE__)
  collection = FilmCollection.from_dir(current_path)
else
  collection = FilmCollection.from_list
end

puts collection

user_choise = STDIN.gets.to_i until collection.directors_range.include?(user_choise)

film = collection.find_film(user_choise - 1)
if film
  puts 'И сегодня вечером рекомендую посмотреть:'
  puts film
else
  puts 'Фильм выбранного режиссёра не найден!'
end
