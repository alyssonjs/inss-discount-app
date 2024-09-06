# spec/services/collaborators/group_by_salary_bracket_service_spec.rb

require 'rails_helper'

RSpec.describe Collaborators::GroupBySalaryBracketService, type: :service do
  let!(:collaborator_1) { create(:collaborator, salary: 500) }
  let!(:collaborator_2) { create(:collaborator, salary: 1500) }
  let!(:collaborator_3) { create(:collaborator, salary: 2500) }
  let!(:collaborator_4) { create(:collaborator, salary: 3500) }
  let!(:collaborator_5) { create(:collaborator, salary: 6500) }
  let!(:collaborator_6) { create(:collaborator, salary: 1500) }
  let!(:collaborator_7) { create(:collaborator, salary: 2500) }
  let!(:collaborator_8) { create(:collaborator, salary: 6500) }
  let!(:collaborator_9) { create(:collaborator, salary: 6500) }
  let!(:collaborator_10) { create(:collaborator, salary: 6500) }
  
  describe '#call' do
    it 'groups collaborators by salary brackets' do
      service = described_class.new
      result = service.call

      expect(result).to eq(
        'Até R$ 1.045,00' => 1,
        'De R$ 1.045,01 a R$ 2.089,60' => 2,
        'De R$ 2.089,61 até R$ 3.134,40' => 2,
        'De R$ 3.134,41 até R$ 6.101,06' => 1
      )
    end
  end
end
