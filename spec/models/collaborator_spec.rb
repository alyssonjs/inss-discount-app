# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Collaborator, type: :model do
  let(:user) { create(:user) }
  let(:valid_attributes) do
    {
      name: Faker::Alphanumeric.alphanumeric(number: 22),
      birthday: Faker::Date.birthday(min_age: 18, max_age: 65),
      personal_phone_number: Faker::PhoneNumber.cell_phone,
      postal_code: Faker::Alphanumeric.alphanumeric(number: 10),
      cpf: Faker::IDNumber.brazilian_citizen_number ,
      city: Faker::Address.city,
      state: Faker::Address.state_abbr,
      address: Faker::Address.full_address,
      neighborhood: Faker::Address.street_name,
      salary: Faker::Number.decimal(l_digits: 4, r_digits: 2) ,
      inss_discount: Faker::Number.decimal(l_digits: 3, r_digits: 2),
      user: user
    }
  end

  before do
    ActiveJob::Base.queue_adapter = :test
  end

  it 'is valid with valid attributes' do
    collaborator = Collaborator.new(valid_attributes)
    expect(collaborator).to be_valid
  end

  it 'is not valid without a name' do
    collaborator = Collaborator.new(valid_attributes.merge(name: nil))
    expect(collaborator).to_not be_valid
  end

  it 'is not valid without a CPF' do
    collaborator = Collaborator.new(valid_attributes.merge(cpf: nil))
    expect(collaborator).to_not be_valid
  end

  it 'is not valid with an invalid CPF' do
    collaborator = Collaborator.new(valid_attributes.merge(cpf: 'invalid_cpf'))
    expect(collaborator).to_not be_valid
    expect(collaborator.errors[:cpf]).to include('é inválido')
  end

  it 'enqueues an UpdateSalaryJob after save if salary changes' do
    expect {
      Collaborator.create!(valid_attributes.merge(salary: 3100.00))
    }.to have_enqueued_job(UpdateSalaryJob).with(an_instance_of(Integer))
  end

  it 'enqueues an UpdateSalaryJob after save if INSS discount changes' do
    expect {
      Collaborator.create!(valid_attributes.merge(inss_discount: 600.00))
    }.to have_enqueued_job(UpdateSalaryJob).with(an_instance_of(Integer))
  end

  it 'does not enqueue an UpdateSalaryJob if neither salary nor INSS discount changes' do
    c = Collaborator.create!(valid_attributes)
    expect {
      c.update(name: 'João')
    }.to_not have_enqueued_job(UpdateSalaryJob)
  end
end
