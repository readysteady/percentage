require 'rational'
require 'bigdecimal'

class Percentage
  attr_reader :value

  include Comparable

  def initialize(value)
    @value = value
  end

  def to_i
    (fractional_value * 100).to_i
  end

  def to_f
    (fractional_value * 100).to_f
  end

  def to_s
    "#{string_value}%"
  end

  def to_r
    fractional_value.to_r
  end

  def zero?
    @value.zero?
  end

  def <=>(object)
    if self.class === object
      fractional_value <=> object.fractional_value
    elsif Numeric === object
      fractional_value <=> object
    end
  end

  def eql?(object)
    object.instance_of?(self.class) && @value.eql?(object.value)
  end

  def hash
    @value.hash
  end

  def +(object)
    if self.class === object
      if @value.integer? ^ object.value.integer?
        self.class.new(fractional_value + object.fractional_value)
      else
        self.class.new(@value + object.value)
      end
    else
      raise TypeError, "cannot add #{object.class} to #{self.class}"
    end
  end

  def *(object)
    case object
    when self.class
      self.class.new(fractional_value.to_r * object.fractional_value)
    else
      fractional_value.coerce(object).inject(&:*)
    end
  end

  def coerce(other)
    case other
    when Numeric
      return fractional_value, other
    else
      raise TypeError, "#{self.class} can't be coerced into #{other.class}"
    end
  end

  def truncate(n)
    self.class.new(fractional_value.truncate(n))
  end

  def scale(n)
    self.class.new(@value * n)
  end

  protected

  def fractional_value
    @fractional_value ||= Integer === @value ? Rational(@value, 100) : @value
  end

  private

  def string_value
    if Integer === @value
      @value.to_s
    elsif BigDecimal === @value
      (@value * 100).to_s('F')
    else
      BigDecimal(@value * 100, _precision=10).to_s('F')
    end
  end
end

def Percentage(object)
  Percentage.new(Integer === object ? object : object / 100)
end

def Percentage.change(a, b)
  Percentage.new((b - a).to_r / a)
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
    n * Percentage.new(self)
  end
end
