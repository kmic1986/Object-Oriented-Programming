class AngryCat
  def initialize(age, name)
    @age  = age
    @name = name
  end

  def age
    puts @age
  end

  def name
    puts @name
  end

  def hiss
    puts "Hisssss!!!"
  end
end

fat = AngryCat.new(14, "Garfield")
kitten = AngryCat.new(1, "Nermal")
p fat
p kitten
