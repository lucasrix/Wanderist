require 'rails_helper'

RSpec.describe Report, type: :model do

  context 'Associations' do
    it { is_expected.to belong_to(:reportable) }
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of(:kind) }
  end

end
