class Bag
  def initialize(color, material)
    @color = color
    @material = material
  end
end

grocery = Bag.new("white", "plastic")
p grocery
