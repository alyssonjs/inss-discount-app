class AdminMailer < ApplicationMailer
  default from: 'no-reply@redsparkle.com'

  def collaborator_created(collaborator, report_data)
    @collaborator = collaborator
    @report_data = report_data
    mail(to: User.where(role: 'admin').last.email, subject: 'Salario do Colaborador Atualizado')
  end
end
