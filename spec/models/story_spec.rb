require 'rails_helper'

RSpec.describe Story, type: :model do
  it { expect(Story).to have_constant(:NAME_MAX_LENGTH) }
  it { expect(Story).to have_constant(:DESCRIPTION_MAX_LENGTH) }

  context 'Associations' do
    it { should belong_to(:user) }
  end

  context 'Validations' do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:description) }
    it { should validate_length_of(:name).is_at_most(Story::NAME_MAX_LENGTH) }
    it { should validate_length_of(:description).is_at_most(Story::DESCRIPTION_MAX_LENGTH) }

  end
end
