class Dog
  def speak
    'bark!'
  end

  def swim
    'swimming!'
  end
end

class Bulldog < Dog
  def swim
    "can't swim!"
  end
end

teddy = Dog.new
roxy = Bulldog.new
puts teddy.speak           # => "bark!"
puts teddy.swim           # => "swimming!"
puts roxy.speak
puts roxy.swim
