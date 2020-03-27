require 'minitest/autorun'
require 'minitest/global_expectations'

require_relative '../lib/percentage'

describe 'Percentage object' do
  it 'is comparable' do
    percentage = Percentage.new(Rational(1, 8))

    (Comparable === percentage).must_equal(true)
  end

  it 'is comparable to other objects of the same class' do
    (Percentage.new(Rational(1, 8)) > Percentage.new(Rational(1, 10))).must_equal(true)
  end

  it 'is comparable to other numeric objects' do
    (Percentage.new(Rational(1, 8)) > Rational(1, 10)).must_equal(true)
  end

  it 'can be used as a hash key' do
    hash = Hash.new(0)

    3.times { hash[Percentage.new(Rational(1, 10))] += 1 }

    hash[Percentage.new(Rational(1, 10))].must_equal(3)
  end

  it 'can be frozen' do
    percentage = Percentage.new(10).freeze
    percentage.frozen?.must_equal(true)
    percentage.to_i.must_equal(10)
  end
end

describe 'Percentage object initialized with an integer value' do
  before do
    @percentage = Percentage.new(10)
  end

  describe 'value method' do
    it 'returns the value passed to the constructor' do
      @percentage.value.must_equal(10)
    end
  end

  describe 'to_i method' do
    it 'returns the integer value of the percentage' do
      @percentage.to_i.must_equal(10)
    end
  end

  describe 'to_f method' do
    it 'returns the float value of the percentage' do
      @percentage.to_f.must_be_close_to(10.0)
    end
  end

  describe 'to_s method' do
    it 'returns the integer value of the percentage suffixed with the percent symbol' do
      @percentage.to_s.must_equal('10%')
    end
  end

  describe 'to_r method' do
    it 'returns the rational value of the percentage' do
      @percentage.to_r.must_equal(Rational(1, 10))
    end
  end

  describe 'zero query method' do
    it 'returns true if the percentage has a zero value' do
      Percentage.new(0).zero?.must_equal(true)
    end

    it 'returns false otherwise' do
      @percentage.zero?.must_equal(false)
    end
  end

  describe 'truncate method' do
    it 'returns a percentage object with a truncated rational value' do
      percentage = @percentage.truncate(1)
      percentage.must_be_instance_of(Percentage)
      percentage.value.must_equal(Rational(1, 10))
    end
  end

  describe 'scale method' do
    it 'returns a percentage object with the value of the percentage multiplied by the integer argument' do
      percentage = @percentage.scale(2)
      percentage.must_be_instance_of(Percentage)
      percentage.value.must_equal(20)
    end
  end
end

describe 'Percentage object initialized with a rational value' do
  before do
    @percentage = Percentage.new(Rational(1, 8))
  end

  describe 'value method' do
    it 'returns the value passed to the constructor' do
      @percentage.value.must_equal(Rational(1, 8))
    end
  end

  describe 'to_i method' do
    it 'returns the integer value of the percentage' do
      @percentage.to_i.must_equal(12)
    end
  end

  describe 'to_f method' do
    it 'returns the float value of the percentage' do
      @percentage.to_f.must_be_close_to(12.5)
    end
  end

  describe 'to_s method' do
    it 'returns the decimal value of the percentage suffixed with the percent symbol' do
      @percentage.to_s.must_equal('12.5%')
    end
  end

  describe 'to_r method' do
    it 'returns the rational value of the percentage' do
      @percentage.to_r.must_equal(Rational(1, 8))
    end
  end

  describe 'zero query method' do
    it 'returns true if the percentage has a zero value' do
      Percentage.new(Rational(0)).zero?.must_equal(true)
    end

    it 'returns false otherwise' do
      @percentage.zero?.must_equal(false)
    end
  end

  describe 'truncate method' do
    it 'returns a percentage object with a truncated rational value' do
      percentage = @percentage.truncate(1)
      percentage.must_be_instance_of(Percentage)
      percentage.value.must_equal(Rational(1, 10))
    end
  end

  describe 'scale method' do
    it 'returns a percentage object with the value of the percentage multiplied by the integer argument' do
      percentage = @percentage.scale(2)
      percentage.must_be_instance_of(Percentage)
      percentage.value.must_equal(Rational(1, 4))
    end
  end
end

describe 'Percentage object initialized with a decimal value' do
  before do
    @percentage = Percentage.new(BigDecimal('0.175'))
  end

  describe 'value method' do
    it 'returns the value passed to the constructor' do
      @percentage.value.must_equal(BigDecimal('0.175'))
    end
  end

  describe 'to_i method' do
    it 'returns the integer value of the percentage' do
      @percentage.to_i.must_equal(17)
    end
  end

  describe 'to_f method' do
    it 'returns the float value of the percentage' do
      @percentage.to_f.must_be_close_to(17.5)
    end
  end

  describe 'to_s method' do
    it 'returns the decimal value of the percentage suffixed with the percent symbol' do
      @percentage.to_s.must_equal('17.5%')
    end
  end

  describe 'to_r method' do
    it 'returns the rational value of the percentage' do
      @percentage.to_r.must_equal(Rational(175, 1000))
    end
  end

  describe 'zero query method' do
    it 'returns true if the percentage has a zero value' do
      Percentage.new(BigDecimal('0')).zero?.must_equal(true)
    end

    it 'returns false otherwise' do
      @percentage.zero?.must_equal(false)
    end
  end

  describe 'truncate method' do
    it 'returns a percentage object with a truncated decimal value' do
      percentage = @percentage.truncate(1)
      percentage.must_be_instance_of(Percentage)
      percentage.value.must_equal(BigDecimal('0.1'))
    end
  end

  describe 'scale method' do
    it 'returns a percentage object with the value of the percentage multiplied by the integer argument' do
      percentage = @percentage.scale(2)
      percentage.must_be_instance_of(Percentage)
      percentage.value.must_equal(BigDecimal('0.35'))
    end
  end
end

describe 'Addition of percentage objects' do
  it 'returns a percentage object with the value of the two percentages added together' do
    percentage = Percentage.new(10) + Percentage.new(10)
    percentage.must_be_instance_of(Percentage)
    percentage.value.must_equal(20)

    percentage = Percentage.new(Rational(1, 8)) + Percentage.new(10)
    percentage.must_be_instance_of(Percentage)
    percentage.value.must_equal(Rational(9, 40))

    percentage = Percentage.new(BigDecimal('0.175')) + Percentage.new(BigDecimal('0.025'))
    percentage.must_be_instance_of(Percentage)
    percentage.value.must_equal(BigDecimal('0.2'))
  end
end

describe 'Addition of percentage object with another type of object' do
  it 'raises an exception' do
    proc { Percentage.new(10) + 5 }.must_raise(TypeError)
  end
end

describe 'Multiplication of percentage objects' do
  it 'returns a percentage object with the fractional value of the two percentages multiplied together' do
    percentage = Percentage.new(10) * Percentage.new(10)
    percentage.must_be_instance_of(Percentage)
    percentage.value.must_equal(Rational(1, 100))

    percentage = Percentage.new(Rational(1, 8)) * Percentage.new(10)
    percentage.must_be_instance_of(Percentage)
    percentage.value.must_equal(Rational(1, 80))

    percentage = Percentage.new(BigDecimal('0.175')) * Percentage.new(10)
    percentage.must_be_instance_of(Percentage)
    percentage.value.must_equal(Rational(7, 400))
  end
end

describe 'Multiplication of a decimal object with a percentage object' do
  it 'returns a decimal object with the value of the decimal multiplied by the fractional value of the percentage' do
    percentage, decimal = Percentage.new(BigDecimal('0.175')), BigDecimal('99.00')

    (decimal * percentage).must_equal(BigDecimal('17.325'))
    (percentage * decimal).must_equal(BigDecimal('17.325'))
  end
end

describe 'Percentage object equality' do
  describe 'double equals method' do
    it 'returns true for percentage objects with the same fractional value' do
      (Percentage.new(50) == Percentage.new(50)).must_equal(true)
      (Percentage.new(50) == Percentage.new(Rational(1, 2))).must_equal(true)
      (Percentage.new(50) == Percentage.new(BigDecimal('0.5'))).must_equal(true)
    end

    it 'returns false otherwise' do
      (Percentage.new(50) == Percentage.new(100)).must_equal(false)
    end
  end

  describe 'eql query method' do
    it 'returns true for percentage objects with exactly the same fractional value' do
      (Percentage.new(50).eql? Percentage.new(50)).must_equal(true)
    end

    it 'returns false otherwise' do
      (Percentage.new(50).eql? Percentage.new(Rational(1, 2))).must_equal(false)
      (Percentage.new(50).eql? Percentage.new(BigDecimal('0.5'))).must_equal(false)
      (Percentage.new(50).eql? Percentage.new(100)).must_equal(false)
    end
  end
end

describe 'Percentage method' do
  describe 'when called with an integer argument' do
    it 'returns a percentage object with the integer value' do
      percentage = Percentage(10)
      percentage.must_be_instance_of(Percentage)
      percentage.value.must_equal(10)
    end
  end

  describe 'when called with a decimal argument' do
    it 'returns a percentage object with the value of the argument divided by 100' do
      percentage = Percentage(BigDecimal('17.5'))
      percentage.must_be_instance_of(Percentage)
      percentage.value.must_equal(BigDecimal('0.175'))
    end
  end

  describe 'when called with a rational argument' do
    it 'returns a percentage object with the value of the argument divided by 100' do
      percentage = Percentage(Rational(100, 3))
      percentage.must_be_instance_of(Percentage)
      percentage.value.must_equal(Rational(1, 3))
    end
  end
end

describe 'Percentage change method' do
  it 'returns the difference between the arguments as a percentage of the first argument' do
    percentage = Percentage.change(2, 3)
    percentage.must_be_instance_of(Percentage)
    percentage.must_equal(Percentage.new(50))
  end
end

describe 'BigDecimal to_percentage method' do
  it 'returns a percentage object with the value of the decimal as a percentage' do
    percentage = BigDecimal(90).to_percentage
    percentage.must_be_instance_of(Percentage)
    percentage.value.must_equal(BigDecimal('0.9'))
  end
end

describe 'BigDecimal percent_of method' do
  it 'returns the value of the receiver as a percentage multiplied by the argument' do
    BigDecimal(90).percent_of(100).must_equal(90)
    BigDecimal(90).percent_of(BigDecimal('15')).must_equal(BigDecimal('13.5'))
    BigDecimal(90).percent_of(Rational(150, 2)).must_equal(Rational(135, 2))
  end
end

describe 'BigDecimal as_percentage_of method' do
  it 'returns a percentage object with the value of the decimal divided by the argument' do
    percentage = BigDecimal('50.00').as_percentage_of(BigDecimal('100.00'))
    percentage.must_be_instance_of(Percentage)
    percentage.value.must_equal(BigDecimal('0.5'))
  end
end

describe 'Integer to_percentage method' do
  it 'returns a percentage object with the value of the integer' do
    percentage = 10.to_percentage
    percentage.must_be_instance_of(Percentage)
    percentage.value.must_equal(10)
  end
end

describe 'Integer percent method' do
  it 'returns a percentage object with the value of the integer' do
    percentage = 10.percent
    percentage.must_be_instance_of(Percentage)
    percentage.value.must_equal(10)
  end
end

describe 'Integer percent_of method' do
  it 'returns the value of the receiver as a percentage multiplied by the argument' do
    10.percent_of(100).must_equal(10)
    10.percent_of(BigDecimal('15')).must_equal(BigDecimal('1.5'))
    10.percent_of(Rational(150, 2)).must_equal(Rational(15, 2))
  end
end

describe 'Integer as_percentage_of method' do
  it 'returns a percentage object with the value of the integer divided by the argument' do
    percentage = 10.as_percentage_of(20)
    percentage.must_be_instance_of(Percentage)
    percentage.value.must_equal(Rational(1, 2))
  end
end
