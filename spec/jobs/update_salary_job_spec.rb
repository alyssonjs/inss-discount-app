# spec/jobs/update_salary_job_spec.rb

require 'rails_helper'
require 'sidekiq/testing'

RSpec.describe UpdateSalaryJob, type: :job do
  let(:collaborator) { create(:collaborator, salary: 3000, inss_discount: 300) }
  let(:report_data) { double('report_data') }

  before do
    Sidekiq::Testing.fake! 
  end

  it 'updates the net_salary of the collaborator' do
    described_class.perform_now(collaborator.id)

    collaborator.reload
    expect(collaborator.net_salary).to eq(2700) # salary - inss_discount
  end

  it 'calls Collaborators::GroupBySalaryBracketService and sends an email' do
    allow(Collaborators::GroupBySalaryBracketService).to receive(:new).and_return(double(call: report_data))
    allow(AdminMailer).to receive_message_chain(:collaborator_created, :deliver_later)

    described_class.perform_now(collaborator.id)

    expect(Collaborators::GroupBySalaryBracketService).to have_received(:new)
    expect(AdminMailer).to have_received(:collaborator_created).with(collaborator, report_data)
  end
end
