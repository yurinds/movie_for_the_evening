class Films
  attr_reader :all_films

  def initialize
    @all_films = {}

    current_path = File.dirname(__FILE__)

    directory_files = Dir.new('films')

    directory_files.each do |file_path|
      next if ['.', '..'].include?(file_path)

      full_path = current_path + '/films/' + file_path
      next unless File.exist?(full_path)

      new_file = File.new(full_path, 'r:UTF-8')
      lines = new_file.readlines
      lines.collect(&:strip!)
      new_file.close

      director = lines[1]
      film = lines[0]
      year = lines[2]

      directors_arr = director.split(/,/)
      directors_arr.collect(&:strip!)

      directors_arr.each do |dir|
        if @all_films[dir]
          @all_films[dir] << [film, year]
        else
          @all_films[dir] = [[film, year]]
        end
      end
    end
  end

  def show_all_directors
    puts 'Программа «Фильм на вечер»'
    puts

    directors = @all_films.keys

    directors.each.with_index(1) do |director, index|
      puts "#{index}: #{director}"
    end
  end

  def show_recommended_film(user_choise)
    if @all_films[user_choise]

      item = @all_films[user_choise].sample

      film = item[0]
      year = item[1]

      puts @all_films[user_choise].sample

      puts
      puts 'И сегодня вечером рекомендую посмотреть:'
      puts "#{user_choise} - #{film} (#{year})"
    end
  end

  def get_user_choise
    print 'Фильм какого режиссера вы хотите сегодня посмотреть? '

    directors = @all_films.keys

    user_choise = 0
    user_choise = STDIN.gets.to_i while user_choise == 0 || user_choise > directors.size

    director = directors[user_choise - 1]
  end
end
