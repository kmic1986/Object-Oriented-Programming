class Board
  WINNING_LINES = [[1, 2, 3], [4, 5, 6], [7, 8, 9]] + # rows
                  [[1, 4, 7], [2, 5, 8], [3, 6, 9]] + # cols
                  [[1, 5, 9], [3, 5, 7]]              # diagonals

  def initialize
    @squares = {}
    reset
  end

  def [](num)
    @squares[num].marker
  end

  def []=(num, marker)
    @squares[num].marker = marker
  end

  def unmarked_keys
    @squares.keys.select { |key| @squares[key].unmarked? }
  end

  def these_keys(var)
    @squares.keys.select { |key| @squares[key].marker == var }
  end

  def immediate_threat(var)
    arr = these_keys(var)
    WINNING_LINES.each do |line|
      if (arr.include? line[0]) && (arr.include? line[1])
        return line[2] if unmarked_keys.include? line[2]
      elsif (arr.include? line[1]) && (arr.include? line[2])
        return line[0] if unmarked_keys.include? line[0]
      end
    end
    return false
  end

  def join(arr)
    case arr.length
    when 1
      arr[0].to_s
    when 2
      arr.join('or')
    else
      arr[0, arr.length - 1].join(', ') + ' or ' + arr[-1].to_s
    end
  end

  def full?
    unmarked_keys.empty?
  end

  def someone_won?
    !!winning_marker
  end

  def winning_marker
    WINNING_LINES.each do |line|
      squares = @squares.values_at(*line)
      if three_identical_markers?(squares)
        return squares.first.marker
      end
    end
    nil
  end

  def reset
    (1..9).each { |key| @squares[key] = Square.new }
  end

  # rubocop:disable Metrics/AbcSize
  def draw
    puts "     |     |"
    puts "  #{@squares[1]}  |  #{@squares[2]}  |  #{@squares[3]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[4]}  |  #{@squares[5]}  |  #{@squares[6]}"
    puts "     |     |"
    puts "-----+-----+-----"
    puts "     |     |"
    puts "  #{@squares[7]}  |  #{@squares[8]}  |  #{@squares[9]}"
    puts "     |     |"
  end
  # rubocop:enable Metrics/AbcSize

  private

  def three_identical_markers?(squares)
    markers = squares.select(&:marked?).collect(&:marker)
    return false if markers.size != 3
    markers.min == markers.max
  end
end

class Square
  INITIAL_MARKER = " ".freeze

  attr_accessor :marker

  def initialize(marker=INITIAL_MARKER)
    @marker = marker
  end

  def to_s
    @marker
  end

  def unmarked?
    marker == INITIAL_MARKER
  end

  def marked?
    marker != INITIAL_MARKER
  end

  def human?
    marker == @human_marker
  end

  def computer?
    marker == @computer_marker
  end

end

class Player
  attr_accessor :name, :score, :marker

  def initialize(marker)
    @marker = marker
    @score = 0
    @name = ''
  end
end

class TTTGame
  @human_marker = "X"
  @computer_marker = "O"
  CHOOSE_MARKER = "C".freeze
  FIRST_TO_MOVE = CHOOSE_MARKER

  attr_reader :board, :human, :computer

  def initialize
    @board = Board.new
    @human = Player.new(@human_marker)
    @computer = Player.new(@computer_marker)
    @current_marker = FIRST_TO_MOVE
    @first_move = @human_marker
  end

  def play
    clear
    display_welcome_message
    names
    select_marker
    choose_first?

    loop do
      display_board

      loop do
        current_player_moves
        break if board.someone_won? || board.full?
        clear_screen_and_display_board if human_turn?
      end

      display_result
      break unless play_again?
      reset
      display_play_again_message
    end

    display_goodbye_message
  end

  private

  def names
    puts "What is your name?"
    human.name = gets.chomp
    computer.name = 'Frank'
    puts "My name is #{computer.name}, nice to meet you, #{human.name}!"
  end

  def select_marker
    puts "Would you like to be X or O?"
    loop do
      ans = gets.chomp.downcase
      if ans == 'x'
        human.marker = 'X'
        computer.marker = 'O'
        @human_marker = 'X'
        @computer_marker = 'O'
        return
      elsif ans == 'o'
        human.marker = 'O'
        computer.marker = 'X'
        @human_marker = 'O'
        @computer_marker = 'X'
        return
      else
        puts "Sorry, try again!"
      end
    end
  end

  def choose_first?
    if @current_marker == CHOOSE_MARKER
      decide_first_move
    end
  end

  def decide_first_move
    puts "Who would you like to go first? (human/computer)"
    loop do
      ans = gets.chomp.downcase
      if ans == 'human'
        @current_marker = human.marker
        @first_move = human.marker
        break
      elsif ans == 'computer'
        @current_marker = computer.marker
        @first_move = computer.marker
        break
      else
        puts "Sorry, try again!"
      end
    end
  end

  def display_welcome_message
    puts "Welcome to Tic Tac Toe!"
    puts ""
  end

  def display_goodbye_message
    str = ''
    if human.score == 5
      puts "Congratulations, #{human.name}! You were first to five!"
    else
      puts "Sorry, #{human.name}! Computer was first to five!"
    end
    puts "Thanks for playing Tic Tac Toe! Goodbye!"
  end

  def clear_screen_and_display_board
    clear
    display_board
  end

  def human_turn?
    @current_marker == human.marker
  end

  def display_board
    puts "You're a '#{human.marker}'. Computer is a '#{computer.marker}'."
    puts ""
    board.draw
    puts ""
  end

  def human_moves
    puts "Choose a square (#{board.join(board.unmarked_keys)}): "
    square = nil
    loop do
      square = gets.chomp.to_i
      break if board.unmarked_keys.include?(square)
      puts "Sorry, that's not a valid choice."
    end

    board[square] = human.marker
  end

  def computer_moves
    if board.immediate_threat(computer.marker)
      board[board.immediate_threat(computer.marker)] = computer.marker
    elsif board.immediate_threat(human.marker)
      board[board.immediate_threat(human.marker)] = computer.marker
    elsif board[5] == Square::INITIAL_MARKER
      board[5] = computer.marker
    else
      board[board.unmarked_keys.sample] = computer.marker
    end
  end

  def current_player_moves
    if human_turn?
      human_moves
      @current_marker = computer.marker
    else
      computer_moves
      @current_marker = human.marker
    end
  end

  def display_result
    clear_screen_and_display_board

    case board.winning_marker
    when human.marker
      puts "You won!"
      human.score += 1
    when computer.marker
      puts "Computer won!"
      computer.score += 1
    else
      puts "It's a tie!"
    end
    sleep(1)
  end

  def play_again?
    human.score < 5 && computer.score < 5
  end

  def clear
    system "cls"
  end

  def reset
    board.reset
    @current_marker = @first_move
    clear
  end

  def display_play_again_message
    puts "Let's play again!"
    puts ""
  end
end

game = TTTGame.new
game.play
