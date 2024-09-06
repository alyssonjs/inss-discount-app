# frozen_string_literal: true

FactoryBot.define do
  factory :collaborator do
    name { Faker::Alphanumeric.alphanumeric(number: 22) }
    cpf { Faker::IDNumber.brazilian_citizen_number }
    birthday { Faker::Date.birthday(min_age: 18, max_age: 65) }
    address { Faker::Address.full_address }
    number { Faker::Address.building_number }
    neighborhood { Faker::Address.street_name }
    city { Faker::Address.city }
    state { Faker::Address.state_abbr }
    postal_code  { Faker::Alphanumeric.alphanumeric(number: 10) }
    personal_phone_number { Faker::PhoneNumber.cell_phone }
    reference { Faker::PhoneNumber.cell_phone }
    reference_phone_number { Faker::PhoneNumber.cell_phone }
    salary { Faker::Number.decimal(l_digits: 4, r_digits: 2) }
    inss_discount { Faker::Number.decimal(l_digits: 3, r_digits: 2) }
    user
  end
end
