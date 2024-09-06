# spec/services/cpf_validator_spec.rb

require 'rails_helper'

RSpec.describe CpfValidator, type: :service do
  describe '.valid?' do
    context 'when the CPF is valid' do
      it 'returns true for a valid CPF' do
        valid_cpf = '123.456.789-09'  # Replace with a valid CPF for your locale
        expect(CpfValidator.valid?(valid_cpf)).to be true
      end
    end

    context 'when the CPF is invalid' do
      it 'returns false for a CPF with incorrect length' do
        invalid_cpf = '123.456.78'
        expect(CpfValidator.valid?(invalid_cpf)).to be false
      end

      it 'returns false for a CPF with all digits the same' do
        invalid_cpf = '111.111.111-11'
        expect(CpfValidator.valid?(invalid_cpf)).to be false
      end

      it 'returns false for a CPF with incorrect check digits' do
        invalid_cpf = '123.456.789-00'  # Ensure this CPF has incorrect check digits
        expect(CpfValidator.valid?(invalid_cpf)).to be false
      end
    end

    context 'when the CPF is an edge case' do
      it 'returns false for a CPF with incorrect check digits' do
        invalid_cpf = '999.999.999-99'  # Ensure this CPF has incorrect check digits
        expect(CpfValidator.valid?(invalid_cpf)).to be false
      end
    end
  end
end
