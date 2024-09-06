# frozen_string_literal: true

# User represents a user in the system, handling authentication and profile information.
class User < ApplicationRecord
  has_secure_password

  validates_presence_of :email, uniqueness: true
  validates :email, format: { with: URI::MailTo::EMAIL_REGEXP }
  validates_presence_of :name, presence: true
  validates_presence_of :password

  has_many :collaborators, dependent: :destroy

  enum role: { collaborator: 'collaborator', admin: 'admin' }

  def admin?
    role == 'admin'
  end

  def collaborator?
    role == 'collaborator'
  end
end
