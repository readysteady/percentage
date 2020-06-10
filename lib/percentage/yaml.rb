require 'yaml'

class Percentage
  def encode_with(coder)
    coder.represent_scalar(nil, to_s)
  end

  module ScalarScannerPatch
    INTEGER = /\A(\d+)%\z/

    DECIMAL = /\A(\d+\.\d+)%\z/

    def tokenize(string)
      if !string.empty? && string.match(INTEGER)
        return Percentage($1.to_i)
      end

      if !string.empty? && string.match(DECIMAL)
        return Percentage(BigDecimal($1))
      end

      super string
    end

    YAML::ScalarScanner.prepend(self)
  end

  private_constant :ScalarScannerPatch
end
