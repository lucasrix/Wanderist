require 'rails_helper'

RSpec.describe Text, type: :model do
  context 'Associations' do
    it { is_expected.to have_one(:content) }
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of(:text) }
  end
end
