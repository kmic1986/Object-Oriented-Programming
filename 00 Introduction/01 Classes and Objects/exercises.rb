class MyCar
  def initialize(year, color, model)
    @year = year
    @color = color
    @model = model
    @speed = 0
  end

  def accelerate(increase)
    @speed += increase
    puts "New speed: #{speed}"
  end

  def decelerate(decrease)
    @speed -= decrease
    puts "New speed: #{speed}"
  end

  def shutoff
    @speed = 0
    puts "New speed: #{speed}"
  end

  attr_accessor :color
  attr_reader :year, :speed

  def spray_paint(color)
    self.color = color
  end

  def self.mileage(odometer, tank_size)
    mileage = odometer / tank_size
    "#{mileage} miles per gallon"
  end

  def to_s
     "You have a #{color} #{year} #{@model}. Speed is #{speed}."
  end
end

car = MyCar.new(1992, 'red', 'Camry')
car.accelerate(10)
car.decelerate(5)
car.shutoff
car.color = 'blue'
puts car.color
puts car.year
car.spray_paint('yellow')
puts car.color
puts MyCar.mileage(450, 15)
puts car
