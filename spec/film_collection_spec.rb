require 'film_collection'
require 'film'
require 'nokogiri'
require 'open-uri'
require 'vcr'
require 'webmock'

VCR.configure do |config|
  config.cassette_library_dir = 'spec/fixtures/vcr_cassettes'
  config.hook_into :webmock
end

describe 'FilmCollection' do
  before(:all) do
    @film_1 = Film.new(director: 'Режиссер 1', title: 'Фильм 1', year: '1995')
    @film_2 = Film.new(director: 'Режиссер 2', title: 'Фильм 2', year: '1996')
    @film_3 = Film.new(director: 'Режиссер 3', title: 'Фильм 3', year: '1997')

    @films = FilmCollection.new([@film_1, @film_2, @film_3])
  end

  it 'assigns instance variables' do
    expect(@films.collection).to eq [@film_1, @film_2, @film_3]
    expect(@films.directors).to eq ['Режиссер 1', 'Режиссер 2', 'Режиссер 3']
    expect(@films.directors_range).to eq (1..3)
  end

  describe '#find_film' do
    it 'indicates an existing index' do
      expect(@films.find_film(1)).to eq @film_2
    end

    it 'indicates a non-existing index' do
      expect(@films.find_film(4)).to eq nil
    end
  end

  describe '.from_list' do
    it 'shows that movies are read from the Internet' do
      VCR.use_cassette('film_collection/from_list') do
        films_from_list = FilmCollection.from_list

        expect(!films_from_list.collection.empty?).to eq true
        expect(films_from_list.collection[0].class == Film).to eq true
        expect(films_from_list.collection[1].title).to eq 'Зеленая миля'
        expect(films_from_list.collection[5].title).to eq 'Леон'
        expect(films_from_list.collection[10].title).to eq 'Жизнь прекрасна'
      end
    end
  end

  describe '.from_dir' do
    it 'shows that movies are read from the dir' do
      current_path = File.dirname(__FILE__)

      films_from_dir = FilmCollection.from_dir(current_path, 'fixtures/films')

      expect(!films_from_dir.collection.empty?).to eq true
      expect(films_from_dir.collection[0].class == Film).to eq true
    end
  end
end
