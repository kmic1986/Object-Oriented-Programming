class Move
  attr_reader :value
  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock'].freeze
end

class Rock < Move
  def to_s
    'rock'
  end

  def >(other_move)
    other_move.to_s == 'scissors' ||
    other_move.to_s == 'lizard'
  end

  def <(other_move)
    other_move.to_s == 'paper' ||
    other_move.to_s == 'spock'
  end
end

class Paper < Move
  def to_s
    'paper'
  end

  def >(other_move)
    other_move.to_s == 'rock' ||
    other_move.to_s == 'spock'
  end

  def <(other_move)
    other_move.to_s == 'scissors' ||
    other_move.to_s == 'lizard'
  end
end

class Scissors < Move
  def to_s
    'scissors'
  end

  def >(other_move)
    other_move.to_s == 'paper' ||
    other_move.to_s ==  'lizard'
  end

  def <(other_move)
    other_move.to_s == 'rock' ||
    other_move.to_s == 'spock'
  end
end

class Lizard < Move
  def to_s
    'lizard'
  end

  def >(other_move)
    other_move.to_s == 'paper' ||
    other_move.to_s == 'spock'
  end

  def <(other_move)
    other_move.to_s == 'rock' ||
    other_move.to_s == 'scissors'
  end
end

class Spock < Move
  def to_s
    'spock'
  end

  def >(other_move)
    other_move.to_s == 'rock' ||
    other_move.to_s == 'scissors'
  end

  def <(other_move)
    other_move.to_s == 'paper' ||
    other_move.to_s == 'lizard'
  end
end

class Player
  attr_accessor :move, :name, :score

  def initialize
    set_name
    @score = 0
  end
end

class Human < Player
  def set_name
    n = ''
    loop do
      puts "What's your name?"
      n = gets.chomp
      break unless n.empty?
      puts "Sorry, must enter a value."
    end
    self.name = n
  end

  def choose
    choice = nil
    loop do
      puts "\nPlease choose #{Move::VALUES[0..-2].join(', ')} or #{Move::VALUES[-1]}:"
      choice = gets.chomp
      break if Move::VALUES.include? choice
      puts "Sorry, invalid choice."
    end
    case choice
    when 'rock'
      self.move = Rock.new
    when 'paper'
      self.move = Paper.new
    when 'scissors'
      self.move = Scissors.new
    when 'lizard'
      self.move = Lizard.new
    when 'spock'
      self.move = Spock.new
    end
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def choose
    choice = Move::VALUES.sample
    case choice
    when 'rock'
      self.move = Rock.new
    when 'paper'
      self.move = Paper.new
    when 'scissors'
      self.move = Scissors.new
    when 'lizard'
      self.move = Lizard.new
    when 'spock'
      self.move = Spock.new
    end
  end
end

class RPSGame
  attr_accessor :human, :computer
  WINNING_SCORE = 10

  def initialize
    @human = Human.new
    @computer = Computer.new
  end

  def display_welcome_message
    system 'cls'
    puts "Welcome to #{Move::VALUES.join(', ')}!".center(80, ' ')
  end

  def display_goodbye_message
    puts "\nThanks for playing Rock, Paper, Scissors. Good Bye!"
  end

  def display_moves
    puts "\n#{human.name} chose #{human.move}."
    puts "#{computer.name} chose #{computer.move}."
  end

  def display_winner
    if human.move > computer.move
      puts "\n#{human.name} won!"
      human.score += 1
    elsif human.move < computer.move
      puts "\n#{computer.name} won!"
      computer.score += 1
    else
      puts "\nIt's a tie!"
    end
  end

  def play_again?
    if human.score == WINNING_SCORE
      winner = human.name
    elsif computer.score == WINNING_SCORE
      winner = computer.name
    else
      return true
    end
    puts "\nWith #{WINNING_SCORE} points, #{winner} is the ultimate champion!"
    false
  end

  def play
    display_welcome_message
    loop do
      human.choose
      computer.choose
      display_moves
      display_winner
      break unless play_again?
    end
    display_goodbye_message
  end
end

RPSGame.new.play
