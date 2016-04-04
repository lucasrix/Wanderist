require 'rails_helper'

RSpec.describe Location, type: :model do
  context 'Validations' do
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }
  end

  describe '#assign_geodata' do
    it 'calls #call on AssignGeodataService' do
      expect(AssignGeodataService).to receive(:call)
      create(:location)
    end
  end
end
