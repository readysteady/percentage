require_relative '../lib/percentage'
require_relative '../lib/percentage/yaml'
require 'bigdecimal/util'

RSpec.describe Percentage do
  it 'is comparable' do
    percentage = Percentage.new(Rational(1, 8))

    expect(percentage).to be_kind_of(Comparable)
  end

  it 'returns frozen instances' do
    percentage = Percentage.new(Rational(1, 8))

    expect(percentage).to be_frozen
  end

  describe '#<=>' do
    it 'supports comparison with other objects of the same class' do
      expect(Percentage.new(Rational(1, 8)) > Percentage.new(Rational(1, 10))).to eq(true)
    end

    it 'supports comparison with other numeric objects' do
      expect(Percentage.new(Rational(1, 8)) > Rational(1, 10)).to eq(true)
    end
  end

  describe '#hash and #eql?' do
    it 'supports being used as a hash key' do
      hash = Hash.new(0)

      3.times { hash[Percentage.new(Rational(1, 10))] += 1 }

      expect(hash[Percentage.new(Rational(1, 10))]).to eq(3)
    end
  end

  describe '#==' do
    it 'returns true for percentage objects with the same fractional value' do
      expect(Percentage.new(50) == Percentage.new(50)).to eq(true)
      expect(Percentage.new(50) == Percentage.new(Rational(1, 2))).to eq(true)
      expect(Percentage.new(50) == Percentage.new(BigDecimal('0.5'))).to eq(true)
    end

    it 'returns false otherwise' do
      expect(Percentage.new(50) == Percentage.new(100)).to eq(false)
    end
  end

  describe '#eql?' do
    it 'returns true for percentage objects with exactly the same fractional value' do
      expect(Percentage.new(50).eql? Percentage.new(50)).to eq(true)
    end

    it 'returns false otherwise' do
      expect(Percentage.new(50).eql? Percentage.new(Rational(1, 2))).to eq(false)
      expect(Percentage.new(50).eql? Percentage.new(BigDecimal('0.5'))).to eq(false)
      expect(Percentage.new(50).eql? Percentage.new(100)).to eq(false)
    end
  end

  describe '#+' do
    context 'with other type of object' do
      it 'raises an exception' do
        expect { Percentage.new(10) + 5 }.to raise_error(TypeError)
      end
    end
  end

  describe '#freeze' do
    it 'returns a frozen instance' do
      percentage = Percentage.new(10).freeze

      expect(percentage.frozen?).to eq(true)
    end
  end
end

RSpec.describe 'Percentage object initialized with an integer value' do
  let(:percentage) { Percentage.new(10) }

  describe '#value' do
    it 'returns the value passed to the constructor' do
      expect(percentage.value).to eq(10)
    end
  end

  describe '#to_i' do
    it 'returns the integer value of the percentage' do
      expect(percentage.to_i).to eq(10)
    end
  end

  describe '#to_f' do
    it 'returns the float value of the percentage' do
      expect(percentage.to_f).to be_within(0.001).of(10.0)
    end
  end

  describe '#to_s' do
    it 'returns the integer value of the percentage suffixed with the percent symbol' do
      expect(percentage.to_s).to eq('10%')
    end
  end

  describe '#to_r' do
    it 'returns the rational value of the percentage' do
      expect(percentage.to_r).to eq(Rational(1, 10))
    end
  end

  describe '#to_d' do
    it 'returns the decimal value of the percentage' do
      expect(percentage.to_d).to eq(BigDecimal('0.1'))
    end
  end

  describe '#zero?' do
    it 'returns true if the percentage has a zero value' do
      expect(Percentage.new(0).zero?).to eq(true)
    end

    it 'returns false otherwise' do
      expect(percentage.zero?).to eq(false)
    end
  end

  describe '#+' do
    it 'returns a percentage object with the value of the two percentages added together' do
      percentage = Percentage.new(10) + Percentage.new(10)

      expect(percentage).to be_a(Percentage)
      expect(percentage.value).to eq(20)
    end
  end

  describe '#*' do
    it 'returns a percentage object with the fractional value of the two percentages multiplied together' do
      percentage = Percentage.new(10) * Percentage.new(10)

      expect(percentage).to be_a(Percentage)
      expect(percentage.value).to eq(Rational(1, 100))
    end
  end

  describe '#truncate' do
    context 'with zero arguments' do
      it 'returns itself' do
        object = percentage.truncate

        expect(object.object_id).to eq(percentage.object_id)
      end
    end

    context 'with an integer argument' do
      it 'returns itself' do
        object = percentage.truncate

        expect(object.object_id).to eq(percentage.object_id)
      end
    end
  end

  describe '#scale' do
    it 'returns a percentage object with the value of the percentage multiplied by the integer argument' do
      object = percentage.scale(2)

      expect(object).to be_a(Percentage)
      expect(object.value).to eq(20)
    end
  end
end

RSpec.describe 'Percentage object initialized with a rational value' do
  let(:percentage) { Percentage.new(Rational(1, 8)) }

  describe '#value' do
    it 'returns the value passed to the constructor' do
      expect(percentage.value).to eq(Rational(1, 8))
    end
  end

  describe '#to_i' do
    it 'returns the integer value of the percentage' do
      expect(percentage.to_i).to eq(12)
    end
  end

  describe '#to_f' do
    it 'returns the float value of the percentage' do
      expect(percentage.to_f).to be_within(0.001).of(12.5)
    end
  end

  describe '#to_s' do
    it 'returns the decimal value of the percentage suffixed with the percent symbol' do
      expect(percentage.to_s).to eq('12.5%')
    end
  end

  describe '#to_r' do
    it 'returns the rational value of the percentage' do
      expect(percentage.to_r).to eq(Rational(1, 8))
    end
  end

  describe '#to_d' do
    it 'returns the decimal value of the percentage' do
      expect(percentage.to_d).to eq(BigDecimal('0.125'))
    end
  end

  describe '#zero?' do
    it 'returns true if the percentage has a zero value' do
      expect(Percentage.new(Rational(0)).zero?).to eq(true)
    end

    it 'returns false otherwise' do
      expect(percentage.zero?).to eq(false)
    end
  end

  describe '#+' do
    it 'returns a percentage object with the value of the two percentages added together' do
      percentage = Percentage.new(Rational(1, 8)) + Percentage.new(10)

      expect(percentage).to be_a(Percentage)
      expect(percentage.value).to eq(Rational(9, 40))
    end
  end

  describe '#*' do
    it 'returns a percentage object with the fractional value of the two percentages multiplied together' do
      percentage = Percentage.new(Rational(1, 8)) * Percentage.new(10)

      expect(percentage).to be_a(Percentage)
      expect(percentage.value).to eq(Rational(1, 80))
    end
  end

  describe '#truncate' do
    context 'with zero arguments' do
      it 'returns a percentage object with an integer value' do
        object = percentage.truncate

        expect(object).to be_a(Percentage)
        expect(object.value).to eq(12)
      end
    end

    context 'with an integer argument' do
      it 'returns a percentage object with a truncated rational value' do
        object = Percentage.new(Rational(3141592, 100000000)).truncate(2)

        expect(object).to be_a(Percentage)
        expect(object.value).to eq(Rational(314, 10000))
      end
    end
  end

  describe '#scale' do
    it 'returns a percentage object with the value of the percentage multiplied by the integer argument' do
      object = percentage.scale(2)

      expect(object).to be_a(Percentage)
      expect(object.value).to eq(Rational(1, 4))
    end
  end
end

RSpec.describe 'Percentage object initialized with a decimal value' do
  let(:percentage) { Percentage.new(BigDecimal('0.175')) }

  describe '#value' do
    it 'returns the value passed to the constructor' do
      expect(percentage.value).to eq(BigDecimal('0.175'))
    end
  end

  describe '#to_i' do
    it 'returns the integer value of the percentage' do
      expect(percentage.to_i).to eq(17)
    end
  end

  describe '#to_f' do
    it 'returns the float value of the percentage' do
      expect(percentage.to_f).to be_within(0.001).of(17.5)
    end
  end

  describe '#to_s' do
    it 'returns the decimal value of the percentage suffixed with the percent symbol' do
      expect(percentage.to_s).to eq('17.5%')
    end
  end

  describe '#to_r' do
    it 'returns the rational value of the percentage' do
      expect(percentage.to_r).to eq(Rational(175, 1000))
    end
  end

  describe '#to_d' do
    it 'returns the decimal value of the percentage' do
      expect(percentage.to_d).to eq(BigDecimal('0.175'))
    end
  end

  describe '#zero?' do
    it 'returns true if the percentage has a zero value' do
      expect(Percentage.new(BigDecimal('0')).zero?).to eq(true)
    end

    it 'returns false otherwise' do
      expect(percentage.zero?).to eq(false)
    end
  end

  describe '#+' do
    it 'returns a percentage object with the value of the two percentages added together' do
      percentage = Percentage.new(BigDecimal('0.175')) + Percentage.new(BigDecimal('0.025'))

      expect(percentage).to be_a(Percentage)
      expect(percentage.value).to eq(BigDecimal('0.2'))
    end
  end

  describe '#*' do
    it 'returns a percentage object with the fractional value of the two percentages multiplied together' do
      percentage = Percentage.new(BigDecimal('0.175')) * Percentage.new(10)

      expect(percentage).to be_a(Percentage)
      expect(percentage.value).to eq(Rational(7, 400))
    end

    context 'with a decimal object' do
      it 'returns a decimal object with the value of the decimal multiplied by the fractional value of the percentage' do
        percentage, decimal = Percentage.new(BigDecimal('0.175')), BigDecimal('99.00')

        expect(decimal * percentage).to eq(BigDecimal('17.325'))
        expect(percentage * decimal).to eq(BigDecimal('17.325'))
      end
    end
  end

  describe '#truncate' do
    context 'with zero arguments' do
      it 'returns a percentage object with an integer value' do
        object = percentage.truncate

        expect(object).to be_a(Percentage)
        expect(object.value).to eq(17)
      end
    end

    context 'with an integer argument' do
      it 'returns a percentage object with a truncated decimal value' do
        object = Percentage.new(BigDecimal('0.03141592')).truncate(2)

        expect(object).to be_a(Percentage)
        expect(object.value).to eq(BigDecimal('0.0314'))
      end
    end
  end

  describe '#scale' do
    it 'returns a percentage object with the value of the percentage multiplied by the integer argument' do
      object = percentage.scale(2)

      expect(object).to be_a(Percentage)
      expect(object.value).to eq(BigDecimal('0.35'))
    end
  end
end

RSpec.describe 'Percentage(object)' do
  describe 'with an integer argument' do
    it 'returns a percentage object with the integer value' do
      percentage = Percentage(10)

      expect(percentage).to be_a(Percentage)
      expect(percentage.value).to eq(10)
    end
  end

  describe 'with a decimal argument' do
    it 'returns a percentage object with the value of the argument divided by 100' do
      percentage = Percentage(BigDecimal('17.5'))

      expect(percentage).to be_a(Percentage)
      expect(percentage.value).to eq(BigDecimal('0.175'))
    end
  end

  describe 'with a rational argument' do
    it 'returns a percentage object with the value of the argument divided by 100' do
      percentage = Percentage(Rational(100, 3))

      expect(percentage).to be_a(Percentage)
      expect(percentage.value).to eq(Rational(1, 3))
    end
  end
end

RSpec.describe 'Percentage.change' do
  it 'returns the difference between the arguments as a percentage of the first argument' do
    percentage = Percentage.change(2, 3)

    expect(percentage).to be_a(Percentage)
    expect(percentage).to eq(Percentage.new(50))
  end

  context 'when the first argument is zero' do
    it 'returns nil' do
      percentage = Percentage.change(0, 1)

      expect(percentage).to be_nil
    end
  end
end

RSpec.describe BigDecimal do
  describe '#to_percentage' do
    it 'returns a percentage object with the value of the decimal as a percentage' do
      percentage = BigDecimal(90).to_percentage

      expect(percentage).to be_a(Percentage)
      expect(percentage.value).to eq(BigDecimal('0.9'))
    end
  end

  describe '#percent_of' do
    it 'returns the value of the receiver as a percentage multiplied by the argument' do
      expect(BigDecimal(90).percent_of(100)).to eq(90)
      expect(BigDecimal(90).percent_of(BigDecimal('15'))).to eq(BigDecimal('13.5'))
      expect(BigDecimal(90).percent_of(Rational(150, 2))).to eq(Rational(135, 2))
    end
  end

  describe '#as_percentage_of' do
    it 'returns a percentage object with the value of the decimal divided by the argument' do
      percentage = BigDecimal('50.00').as_percentage_of(BigDecimal('100.00'))

      expect(percentage).to be_a(Percentage)
      expect(percentage.value).to eq(BigDecimal('0.5'))
    end
  end
end

RSpec.describe Integer do
  describe '#to_percentage' do
    it 'returns a percentage object with the value of the integer' do
      percentage = 10.to_percentage

      expect(percentage).to be_a(Percentage)
      expect(percentage.value).to eq(10)
    end
  end

  describe '#percent' do
    it 'returns a percentage object with the value of the integer' do
      percentage = 10.percent

      expect(percentage).to be_a(Percentage)
      expect(percentage.value).to eq(10)
    end
  end

  describe '#percent_of' do
    it 'returns the value of the receiver as a percentage multiplied by the argument' do
      expect(10.percent_of(100)).to eq(10)
      expect(10.percent_of(BigDecimal('15'))).to eq(BigDecimal('1.5'))
      expect(10.percent_of(Rational(150, 2))).to eq(Rational(15, 2))
    end
  end

  describe '#as_percentage_of' do
    it 'returns a percentage object with the value of the integer divided by the argument' do
      percentage = 10.as_percentage_of(20)

      expect(percentage).to be_a(Percentage)
      expect(percentage.value).to eq(Rational(1, 2))
    end
  end
end

RSpec.describe 'YAML' do
  let(:integer_percentage) { Percentage.new(10) }
  let(:decimal_percentage) { Percentage.new(BigDecimal('0.175')) }
  let(:rational_percentage) { Percentage.new(Rational(1, 8)) }

  describe '.dump' do
    it 'dumps percentage objects' do
      expect(YAML.dump([integer_percentage])).to eq("---\n- 10%\n")
      expect(YAML.dump([decimal_percentage])).to eq("---\n- 17.5%\n")
      expect(YAML.dump([rational_percentage])).to eq("---\n- 12.5%\n")
    end
  end

  describe '.load' do
    it 'loads percentage objects' do
      expect(YAML.load("---\n- 10%\n")).to eq([integer_percentage])
      expect(YAML.load("---\n- 17.5%\n")).to eq([decimal_percentage])
    end
  end
end
