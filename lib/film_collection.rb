class FilmCollection
  attr_reader :collection, :directors, :directors_range

  def initialize(films = [])
    @collection = films
    @directors = get_directors
    @directors_range = get_directors_range
  end

  def to_s
    text = "Программа «Фильм на вечер»\n\n"

    @directors.each.with_index(1) do |director, index|
      text += "#{index}: #{director}\n"
    end
    text += 'Фильм какого режиссера вы хотите сегодня посмотреть?'
  end

  def find_film(index)
    director = find_director(index)
    return nil unless director

    films = @collection.select { |film| film.directors.include?(director) }
    films.sample
  end

  def self.from_dir(current_path, films_path = 'data/films')
    films = []
    Dir.new("#{current_path}/#{films_path}").each do |dir_path|
      next if ['.', '..'].include?(dir_path)

      full_path = current_path + "/#{films_path}/" + dir_path
      films << Film.from_file(full_path) if File.exist?(full_path)
    end
    new(films)
  end

  def self.from_list
    doc = Nokogiri::HTML(open('https://www.kinopoisk.ru/top/lists/1/'))
    films = []
    doc.css('table#itemList .news').each do |link|
      en_title = link.css("span[style='color: #888; font-family: arial; font-size: 11px; display: block']").text.strip

      year = en_title.split('(').last.split(')').first
      title = link.css('.all').first.text.strip

      film_info = link.css('.gray_text').first.text.split("\n")
      film_info.map! { |item| item.strip.gsub(/\,|\(|\)|реж.|\./, '') }
      film_info.reject!(&:empty?)

      director = film_info[1]

      films << Film.new(
        title: title,
        director: director,
        year: year
      )
    end

    new(films)
  end

  private

  def get_directors_range
    (1..@directors.size)
  end

  def find_director(index)
    @directors[index]
  end

  def get_directors
    all_directors = []
    @collection.each do |film|
      all_directors |= film.directors
    end
    all_directors
  end
end
