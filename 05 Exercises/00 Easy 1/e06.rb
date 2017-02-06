class Cube
  def initialize(volume)
    @volume = volume
  end

  attr_accessor :volume
end

rubiks = Cube.new(20)
puts rubiks.volume
rubiks.volume = 10
puts rubiks.volume
