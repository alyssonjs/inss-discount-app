# frozen_string_literal: true

module Collaborators
  # GroupBySalaryBracketService groups collaborators by their salary brackets for reporting purposes.
  class GroupBySalaryBracketService
    SALARY_BRACKETS = {
      'Até R$ 1.045,00' => (0..1045),
      'De R$ 1.045,01 a R$ 2.089,60' => (1045.01..2089.60),
      'De R$ 2.089,61 até R$ 3.134,40' => (2089.61..3134.40),
      'De R$ 3.134,41 até R$ 6.101,06' => (3134.41..6101.06)
    }.freeze

    def initialize(collaborators = Collaborator.all)
      @collaborators = collaborators
    end

    def call
      return Hash.new(0) if @collaborators.empty?

      @brackets_count ||= calculate_brackets_count
    end

    private

    def calculate_brackets_count
      brackets_count = Hash.new(0)

      @collaborators.find_each do |collaborator|
        bracket = find_bracket_for_salary(collaborator.salary)
        brackets_count[bracket] += 1 if bracket
      end

      brackets_count
    end

    def find_bracket_for_salary(salary)
      SALARY_BRACKETS.find { |_bracket, range| range.include?(salary) }&.first
    end
  end
end
