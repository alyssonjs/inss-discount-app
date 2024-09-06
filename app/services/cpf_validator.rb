# frozen_string_literal: true

class CpfValidator
  def self.valid?(cpf)
    new(cpf).valid?
  end

  def initialize(cpf)
    @cpf = cpf.to_s.gsub(/\D/, '') # Remove qualquer caractere não numérico
  end

  def valid?
    return false if invalid_length? || all_digits_same?

    expected_check_digits == actual_check_digits
  end

  private

  def invalid_length?
    @cpf.length != 11
  end

  def all_digits_same?
    @cpf.chars.uniq.length == 1
  end

  def expected_check_digits
    digits = @cpf[0..8].chars.map(&:to_i)
    d1 = calculate_digit(digits, 10)
    d2 = calculate_digit(digits + [d1], 11)
    [d1, d2]
  end

  def actual_check_digits
    @cpf[9..10].chars.map(&:to_i)
  end

  def calculate_digit(digits, weight)
    sum = digits.each_with_index.reduce(0) do |acc, (digit, index)|
      acc + (digit * (weight - index))
    end
    remainder = sum % 11
    remainder < 2 ? 0 : 11 - remainder
  end
end
