class Person
  def initialize(name)
    @name = name
  end

  attr_accessor :name
end

bob = Person.new('bob')
puts bob.name                  # => 'bob'
bob.name = 'Robert'
puts bob.name
