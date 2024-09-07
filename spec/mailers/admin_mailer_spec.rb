require "rails_helper"

RSpec.describe AdminMailer, type: :mailer do
  describe 'collaborator_created' do
    let!(:admin) { create(:user, role: 'admin') }
    let!(:collaborator) { create(:collaborator, user: admin) }

    let(:report_data) do
      {
        'Até R$ 1.045,00' => 2,
        'De R$ 1.045,01 a R$ 2.089,60' => 3,
        'De R$ 2.089,61 até R$ 3.134,40' => 3,
        'De R$ 3.134,41 até R$ 6.101,06' => 2
      }
    end
    let(:mail) { AdminMailer.with(collaborator: collaborator, report_data: report_data).collaborator_created(collaborator, report_data) }

    it 'renders the headers' do
      expect(mail.subject).to eq('Salario do Colaborador Atualizado')
      expect(mail.to).to eq([admin.email])
      expect(mail.from).to eq(['no-reply@redspark.com'])
    end
  end
end
