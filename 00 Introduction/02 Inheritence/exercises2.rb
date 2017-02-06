class Student
  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def better_grade_than?(student)
    self.grade > student.grade
  end

  protected

  def grade
    @grade
  end
end

joe = Student.new('joe', 92)
bob = Student.new('bob', 87)
puts joe.better_grade_than?(bob)
puts bob.better_grade_than?(joe)
