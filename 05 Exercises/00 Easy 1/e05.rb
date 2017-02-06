class Fruit
  def initialize(name)
    name = name
  end
end

class Pizza
  def initialize(name)
    @name = name
  end
end

banana = Fruit.new("banana")
pepperoni = Pizza.new("pepperoni")

p pepperoni.instance_variables
p banana.instance_variables
