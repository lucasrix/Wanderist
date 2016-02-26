require 'rails_helper'

RSpec.describe Report, type: :model do
  context 'Associations' do
    it { should belong_to(:reportable) }
  end

  context 'Validations' do
    it { should validate_presence_of(:kind) }
  end
end
