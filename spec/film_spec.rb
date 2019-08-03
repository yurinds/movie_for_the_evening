require 'film'

describe 'Film' do
  it 'assigns instance variables' do
    film = Film.new(director: 'Роджер Аллерс, Роб Минкофф', title: 'Король Лев', year: '1994')

    expect(film.directors).to eq ['Роджер Аллерс', 'Роб Минкофф']
    expect(film.title).to eq 'Король Лев'
    expect(film.year).to eq '1994'
  end

  describe '#from_file' do
    it 'reads from file' do
      current_path = File.dirname(__FILE__)

      film = Film.from_file("#{current_path}/fixtures/test.txt")

      expect(film.directors).to eq ['Квентин Тарантино']
      expect(film.title).to eq 'Однажды в… Голливуде'
      expect(film.year).to eq '2019'
    end
  end

  describe '#to_s' do
    it 'displays a movie view' do
      film = Film.new(director: 'Роджер Аллерс, Роб Минкофф', title: 'Король Лев', year: '1994')
      expect(film.to_s).to eq 'Роджер Аллерс, Роб Минкофф - Король Лев (1994)'
    end
  end
end
