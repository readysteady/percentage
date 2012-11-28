require 'rational'
require 'bigdecimal'

class Percentage
  attr_reader :value

  include Comparable

  def initialize(fraction)
    @value = fraction
  end

  def to_i
    (@value * 100).to_i
  end

  def to_f
    (@value * 100).to_f
  end

  def to_s
    "#{decimal_value}%"
  end

  def to_r
    @value.to_r
  end

  def zero?
    @value.zero?
  end

  def <=>(object)
    if self.class === object
      @value <=> object.value
    elsif Numeric === object
      @value <=> object
    end
  end

  def eql?(object)
    object.instance_of?(self.class) && @value.eql?(object.value)
  end

  def ==(object)
    object.instance_of?(self.class) && @value == object.value
  end

  def hash
    @value.hash
  end

  def *(object)
    case object
    when Integer
      self.class.new(@value * object)
    when self.class
      self.class.new(@value * object.value)
    else
      raise ArgumentError, "#{object.class} cannot be used to multiply a percentage"
    end
  end

  def coerce(other)
    case other
    when Numeric
      return @value, other
    else
      raise TypeError, "#{self.class} can't be coerced into #{other.class}"
    end
  end

  def truncate(n)
    self.class.new(@value.truncate(n))
  end

  private

  def decimal_value
    if BigDecimal === @value
      (@value * 100).to_s('F')
    else
      BigDecimal(@value * 100, _precision=10).to_s('F')
    end
  end
end

def Percentage(object)
  if Integer === object
    Percentage.new(Rational(object, 100))
  else
    Percentage.new(object / 100)
  end
end

class BigDecimal
  def as_percentage_of(n)
    Percentage.new(self / n)
  end
end

class Integer
  def as_percentage_of(n)
    Percentage.new(Rational(self, n))
  end

  def percent_of(n)
    n * Percentage(self)
  end
end
