require_relative './films.rb'

films = Films.new
films.show_all_directors
choise = films.get_user_choise
films.show_recommended_film(choise)
