# frozen_string_literal: true

# ApplicationHelper provides helper methods that are used across the entire application.
module ApplicationHelper
  def format_to_currency(value)
    return '' if value.blank?

    number_to_currency(value, unit: 'R$', delimiter: '.', separator: ',', format: '%u %n')
  end
end
