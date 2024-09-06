# frozen_string_literal: true

module Collaborators
  class InssCalculator
    attr_reader :errors, :response

    RANGES = [
      { max: 1_045.00, rate: 0.075 },
      { max: 2_089.60, rate: 0.09 },
      { max: 3_134.40, rate: 0.12 },
      { max: 6_101.06, rate: 0.14 }
    ].freeze

    def initialize(salary)
      @salary = salary
      @response = ''
      @errors = []
    end

    def prepare_inss
      validate_input
      @response = calc_inss
      @response = format_to_currency(@response) # Formatar para moeda brasileira
    rescue ArgumentError => e
      @errors << e.message
      @response = 'R$ 0,00'
    end

    private

    def validate_input
      parsed_salary = parse_salary(@salary)
      raise ArgumentError, 'Entrada inválida. Informe um número válido.' if parsed_salary.nil? || parsed_salary <= 0
      @salary = parsed_salary
    end

    def parse_salary(salary)
      Float(salary.gsub(',', '.')) rescue nil
    end

    def calc_inss
      return 0 if @salary <= 0

      total = 0
      previous_limit = 0

      RANGES.each do |range|
        if @salary > range[:max]
          total += (range[:max] - previous_limit) * range[:rate]
          previous_limit = range[:max]
        else
          total += (@salary - previous_limit) * range[:rate]
          break
        end
      end

      total.round(2)
    end

    def format_to_currency(value)
      "R$ #{'%.2f' % value}".gsub('.', ',')
    end
  end
end
