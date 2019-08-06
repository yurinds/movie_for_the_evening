require 'film_collection'
require 'film'
require 'nokogiri'
require 'open-uri'

describe 'FilmCollection' do
  it 'assigns instance variables' do
    film_1 = Film.new(director: 'Режиссер 1', title: 'Фильм 1', year: '1995')
    film_2 = Film.new(director: 'Режиссер 2', title: 'Фильм 2', year: '1996')
    film_3 = Film.new(director: 'Режиссер 3', title: 'Фильм 3', year: '1997')

    films = FilmCollection.new([film_1, film_2, film_3])

    expect(films.collection).to eq [film_1, film_2, film_3]
    expect(films.directors).to eq ['Режиссер 1', 'Режиссер 2', 'Режиссер 3']
    expect(films.directors_range).to eq (1..3)
  end

  describe '#find_film' do
    it 'indicates an existing index' do
      film_1 = Film.new(director: 'Режиссер 1', title: 'Фильм 1', year: '1995')
      film_2 = Film.new(director: 'Режиссер 2', title: 'Фильм 2', year: '1996')
      film_3 = Film.new(director: 'Режиссер 3', title: 'Фильм 3', year: '1997')

      films = FilmCollection.new([film_1, film_2, film_3])

      expect(films.find_film(1)).to eq film_2
    end

    it 'indicates a non-existing index' do
      film_1 = Film.new(director: 'Режиссер 1', title: 'Фильм 1', year: '1995')
      film_2 = Film.new(director: 'Режиссер 2', title: 'Фильм 2', year: '1996')
      film_3 = Film.new(director: 'Режиссер 3', title: 'Фильм 3', year: '1997')

      films = FilmCollection.new([film_1, film_2, film_3])

      expect(films.find_film(4)).to eq nil
    end
  end

  describe '#self.from_list' do
    it 'shows that movies are read from the Internet' do
      films = FilmCollection.from_list

      expect(!films.collection.empty?).to eq true
      expect(films.collection[0].class == Film).to eq true
    end
  end

  describe '#self.from_dir' do
    it 'shows that movies are read from the dir' do
      current_path = File.dirname(__FILE__)

      films = FilmCollection.from_dir(current_path, 'fixtures/films')

      expect(!films.collection.empty?).to eq true
      expect(films.collection[0].class == Film).to eq true
    end
  end
end