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
end

bob = Person.new('Robert')
puts bob.name                  # => 'Robert'
puts bob.first_name            # => 'Robert'
puts bob.last_name             # => ''
bob.last_name = 'Smith'
puts bob.name                  # => 'Robert Smith'

bob.name = "John Adams"
puts bob.first_name            # => 'John'
puts bob.last_name             # => 'Adams'
