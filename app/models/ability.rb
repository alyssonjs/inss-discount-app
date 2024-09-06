# frozen_string_literal: true

# Ability class defines the user permissions for the application using CanCanCan.
class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # Guest user (não logado)

    if user.admin?
      can :manage, :all # Administrador pode gerenciar tudo
    elsif user.collaborator?
      can :read, Collaborator # Colaborador pode ler colaboradores
      can :update, Collaborator
    end
  end
end
