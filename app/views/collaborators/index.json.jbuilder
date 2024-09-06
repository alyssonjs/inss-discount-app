# frozen_string_literal: true

json.array! @collaborators, partial: 'collaborators/collaborator', as: :collaborator
