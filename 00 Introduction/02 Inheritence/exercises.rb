class Vehicle

  attr_accessor :color
  attr_reader :model, :year
  @@number_of_vehicles = 0

  def initialize(year, model, color)
    @year = year
    @model = model
    @color = color
    @current_speed = 0
    @@number_of_vehicles += 1
  end

  def speed_up(number)
    @current_speed += number
    puts "You speed up to #{@current_speed}."
  end

  def brake(number)
    @current_speed -= number
    puts "You slow down to #{@current_speed}."
  end

  def current_speed
    puts "You are going #{@current_speed}."
  end

  def shut_down
    @current_speed = 0
    puts "Speed is #{@current_speed}. You are parked."
  end

  def self.mileage(miles, gallons)
    puts "#{miles / gallons} miles per gallon."
  end

  def spray_paint(color)
    self.color = color
    puts "Your vehicle is now #{@color}."
  end

  def self.n_vehicles
    puts "#{@@number_of_vehicles} vehicles."
  end

  def age
    "Your #{self.model} is #{years_old} years old."
  end

  private

  def years_old
    Time.now.year - self.year
  end
end

module Fourwheelable
  def fourwheel
    puts "Offroading!"
  end
end

class MyCar < Vehicle
  NUMBER_OF_DOORS = 4

  def to_s
    "My car is a #{self.color}, #{self.year} #{self.model}."
  end
end

class MyTruck < Vehicle
  NUMBER_OF_DOORS = 2
  include Fourwheelable

  def to_s
    "My truck is a #{self.color}, #{self.year} #{self.model}."
  end
end

car = MyCar.new(1992, 'Camry', 'maroon')
truck = MyTruck.new(1995, 'F-150', 'blue')
Vehicle.n_vehicles
truck.fourwheel
car.speed_up(20)
truck.speed_up(20)
car.current_speed
truck.current_speed
car.brake(5)
truck.brake(5)
car.current_speed
truck.current_speed
car.shut_down
truck.shut_down
MyCar.mileage(425, 13)
car.spray_paint("black")
truck.spray_paint("yellow")
puts car
puts truck
puts MyCar.ancestors
puts MyTruck.ancestors
puts Vehicle.ancestors
puts car.age
puts truck.age
