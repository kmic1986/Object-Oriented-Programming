class Move
  attr_reader :value

  VALUES = ['rock', 'paper', 'scissors', 'lizard', 'spock'].freeze
end

class Rock < Move
  def to_s
    'rock'
  end

  def to_sym
    :rock
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

  def to_sym
    :paper
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

  def to_sym
    :scissors
  end

  def >(other_move)
    other_move.to_s == 'paper' ||
    other_move.to_s == 'lizard'
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

  def to_sym
    :lizard
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

  def to_sym
    :spock
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
  attr_accessor :move, :name, :score, :history

  def initialize
    set_name
    @score = 0
    @history = {rock: {w: 0, l: 0, t: 0},
                paper: {w: 0, l: 0, t: 0},
                scissors: {w: 0, l: 0, t: 0},
                lizard: {w: 0, l: 0, t: 0},
                spock: {w: 0, l: 0, t: 0}
               }
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
    self.history[choice.to_sym][:t] += 1
  end
end

class Computer < Player
  def set_name
    self.name = ['R2D2', 'Hal', 'Chappie', 'Sonny', 'Number 5'].sample
  end

  def weigh_choices
    if self.name == 'Hal'
      options = []
      final = -100
      self.history.each do |move_hash|
        options << move_hash[1][:w] - move_hash[1][:l]
      end
      options.each_index do |idx|
        if options[idx] > final
          final = options[idx]
        end
      end
      if final == 0
        return Move::VALUES.sample
      else
        return Move::VALUES[options.index(final)]
      end
    elsif self.name == 'R2D2'
      return 'rock'
    else
      self.history.each do |move_hash|
        if move_hash[1][:t] == 0
          return move_hash[0].to_s
        end
      end
      return Move::VALUES.sample
    end
  end

  def choose
    choice = weigh_choices
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
    self.history[choice.to_sym][:t] += 1
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

  def display_scoreboard
    system 'cls'
    puts "#{human.name}: #{human.score}" +
          ' ' * 20 +
          "#{computer.name}: #{computer.score}".center(80, ' ')
    Move::VALUES.each do |move|
      puts "#{move}: #{human.history[move.to_sym][:t]}" +
            ' ' * 20 +
            "#{move}: #{computer.history[move.to_sym][:t]}".center(80, ' ')
    end
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
      human.history[human.move.to_sym][:w] += 1
      computer.history[computer.move.to_sym][:l] += 1
    elsif human.move < computer.move
      puts "\n#{computer.name} won!"
      computer.score += 1
      human.history[human.move.to_sym][:l] += 1
      computer.history[computer.move.to_sym][:w] += 1
    else
      puts "\nIt's a tie!"
    end
    gets
    display_scoreboard
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
