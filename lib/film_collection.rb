class FilmCollection
  attr_reader :collection, :directors, :directors_range

  def initialize(films = [])
    @collection = films
    @directors = get_directors
    @directors_range = get_directors_range
  end

  def get_directors_range
    (1..@directors.size)
  end

  def get_directors
    all_directors = []
    @collection.each do |film|
      all_directors |= film.directors
    end
    all_directors
  end

  def self.from_dir(current_path)
    films = []
    Dir.new('data/films').each do |dir_path|
      next if ['.', '..'].include?(dir_path)

      full_path = current_path + '/data/films/' + dir_path
      films << Film.from_file(full_path) if File.exist?(full_path)
    end
    new(films)
  end

  def to_s
    text = "Программа «Фильм на вечер»\n\n"

    @directors.each.with_index(1) do |director, index|
      text += "#{index}: #{director}\n"
    end
    text += 'Фильм какого режиссера вы хотите сегодня посмотреть?'
  end

  def find_director(user_input)
    @directors[user_input - 1]
  end

  def find_film(user_input)
    director = find_director(user_input)
    return nil unless director

    films = @collection.select { |film| film.directors.include?(director) }
    films.sample
  end
end
