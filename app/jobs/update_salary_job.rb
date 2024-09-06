# frozen_string_literal: true

class UpdateSalaryJob < ApplicationJob
  queue_as :default

  def perform(collaborator_id)
    collaborator = Collaborator.find(collaborator_id)
    collaborator.update(net_salary: collaborator.salary - collaborator.inss_discount)
    report_data = Collaborators::GroupBySalaryBracketService.new.call
    AdminMailer.collaborator_created(collaborator, report_data).deliver_later
  end
end
