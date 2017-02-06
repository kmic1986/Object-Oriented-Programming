class BeesWax
  def initialize(type)
    @type = type
  end

  attr_accessor :type

  def describe_type
    puts "I am a #{type} of Bees Wax"
  end
end

sticky = BeesWax.new("sticky")
puts sticky.type
sticky.type = "gooey"
puts sticky.type
