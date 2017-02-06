module Speak
  def speak(str)
    puts str
  end
end

class GoodDog
  include Speak
end

daisy = GoodDog.new
daisy.speak("Woof!")
