# frozen_string_literal: true

class CreateCollaborators < ActiveRecord::Migration[5.2]
  def change
    create_table :collaborators do |t|
      t.string :name
      t.string :cpf
      t.references :user, foreign_key: true
      t.date :birthday
      t.string :address
      t.integer :number
      t.string :neighborhood
      t.string :city
      t.string :state
      t.string :postal_code
      t.string :personal_phone_number
      t.string :reference
      t.string :reference_phone_number
      t.decimal :salary, precision: 10, scale: 2
      t.decimal :inss_discount, precision: 10, scale: 2
      t.decimal :net_salary, precision: 10, scale: 2

      t.timestamps
    end
  end
end
