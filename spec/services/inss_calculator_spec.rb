# spec/services/collaborators/inss_calculator_spec.rb

require 'rails_helper'

RSpec.describe Collaborators::InssCalculator, type: :service do
  describe '#prepare_inss' do
    context 'with valid salaries' do
      it 'calculates INSS for a salary of R$ 1.500,00' do
        calculator = described_class.new('1500,00')
        calculator.prepare_inss
        expect(calculator.response).to eq('R$ 119,32')
      end

      it 'calculates INSS for a salary of R$ 2.500,00' do
        calculator = described_class.new('2500,00')
        calculator.prepare_inss
        expect(calculator.response).to eq('R$ 221,64')
      end

      it 'calculates INSS for a salary of R$ 3.500,00' do
        calculator = described_class.new('3500,00')
        calculator.prepare_inss
        expect(calculator.response).to eq('R$ 348,95')
      end

      it 'calculates INSS for a salary of R$ 6.500,00' do
        calculator = described_class.new('6500,00')
        calculator.prepare_inss
        expect(calculator.response).to eq('R$ 713,10')
      end
    end

    context 'with invalid salary format' do
      it 'returns formatted zero for a salary of R$ 0,00' do
        calculator = described_class.new('0,00')
        calculator.prepare_inss
        expect(calculator.response).to eq('R$ 0,00')
      end

      it 'returns formatted zero for a negative salary' do
        calculator = described_class.new('-1000,00')
        calculator.prepare_inss
        expect(calculator.response).to eq('R$ 0,00')
      end
    end

    context 'with invalid input' do
      it 'handles non-numeric input gracefully' do
        invalid_salary = 'invalid'
        calculator = described_class.new(invalid_salary)
        calculator.prepare_inss
        expect(calculator.errors).to include('Entrada inválida. Informe um número válido.')
        expect(calculator.response).to eq('R$ 0,00')
      end
    end
  end
end
