class Luhn
  class << self
    def valid?(luhn_number)
      return false if luhn_number.gsub(/\s/, '').length <= 1
      return false if luhn_number.gsub(/\s/, '') =~ /\D/

      luhn_number.gsub(/\s/, '').split('').reverse.each_with_index.map do |digit, index|

        digit = digit.to_i
        if index.odd?
          digit *= 2
          digit -= 9 if digit > 9
        end
        digit
      end
        .sum % 10 == 0
    end
  end
end
