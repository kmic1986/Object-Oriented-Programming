class Person
  def initialize(full)
    parts = full.split(' ')
    @first_name = parts.first
    @last_name = parts.size > 1 ? parts.last : ''
  end

  attr_accessor :first_name, :last_name

  def name
    "#{first_name} #{last_name}".strip
  end

  def name=(full)
    parts = full.split(' ')
    self.first_name = parts.first
    self.last_name = parts.size > 1 ? parts.last : ''
  end

  def to_s
    name
  end
end

bob = Person.new('Robert Smith')
puts "The person's name is: " + bob.name
puts "The person's name is: #{bob}"
