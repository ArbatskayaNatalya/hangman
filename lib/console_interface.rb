class ConsoleInterface
  # Все текстовые файлы из папки figures
  FIGURES =
    Dir["#{__dir__}/../data/figures/*.txt"].
    sort.
    map { |file_name| File.read(file_name) }

  # На вход конструктор класса ConsoleInterface принимает экземпляр класса Game.
  def initialize(game)
    @game = game
  end

  # Выводит в консоль текущее состояние игры, используя данные из экземпляра
  # класса Game (количество ошибок, сколько осталось попыток и т.д.)
  def print_out
    puts <<~GAMESTATUS
      Слово: #{word_to_show}
      #{figure}
      Ошибки (#{@game.errors_made}): #{errors_to_show}
      У вас осталось ошибок: #{@game.errors_allowed}

    GAMESTATUS

    if @game.won?
      puts "Поздравляем, вы выиграли!"
    elsif @game.lost?
      puts "Вы проиграли, загаданное слово: #{@game.word}"
    end
  end

  # Возвращает ту фигуру из массива FIGURES, которая соответствует количеству
  # ошибок, сделанных пользователем на данный момент (число ошибок берем у
  # экземпляра класса Game)
  def figure
    FIGURES[@game.errors_made]
  end

  # Метод, который готовит слово для вывода "на игровом табло".
  def word_to_show
    result =
      @game.letters_to_guess.map do |letter|
        if letter.nil?
          "__"
        else
          letter
        end
      end

    result.join(" ")
  end

  def errors_to_show
    @game.errors.join(", ")
  end

  # Получает букву из пользовательского ввода, приводит её к верхнему регистру
  # и возвращает её
  def get_input
    print "Введите следующую букву: "
    gets[0].upcase
  end
end
