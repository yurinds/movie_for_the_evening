class Film
  attr_reader :directors, :title, :year

  def initialize(params)
    @directors = get_directors(params[:director])
    @title = params[:title]
    @year = params[:year]
  end

  def get_directors(director_string)
    directors_arry = director_string.split(/,/)
    directors_arry.map(&:strip)
  end

  def self.from_file(path)
    film = File.readlines(path, chomp: true)

    new(
      title: film[0],
      director: film[1],
      year: film[2]
    )
  end

  def to_s
    "#{@directors.join(', ')} - #{@title}(#{@year})"
  end
end
