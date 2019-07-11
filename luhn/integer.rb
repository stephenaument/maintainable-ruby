# Additions to the Integer class
class Integer
  def divisible_by?(number)
    self % number == 0
  end
end
