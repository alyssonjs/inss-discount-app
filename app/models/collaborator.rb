# frozen_string_literal: true

# Collaborator represents a collaborator (employee) in the system, handling their attributes and operations.
class Collaborator < ApplicationRecord

  validates_presence_of :name, :birthday, :personal_phone_number
  validates :postal_code, length: { minimum: 10 }, presence: true
  validates :cpf, presence: true, uniqueness: true
  validate :cpf_format
  validates_presence_of :city, :state, :address, :neighborhood, :salary, :inss_discount
  after_save :enqueue_salary_update, if: :salary_or_inss_discount_changed?

  belongs_to :user


  private

  def cpf_format
    return if CpfValidator.valid?(cpf)

    errors.add(:cpf, 'é inválido')
  end

  def enqueue_salary_update
    UpdateSalaryJob.perform_later(id)
  end

  def salary_or_inss_discount_changed?
    saved_change_to_salary? || saved_change_to_inss_discount?
  end

end
