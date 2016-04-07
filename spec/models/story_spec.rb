require 'rails_helper'

RSpec.describe Story, type: :model do
  it_behaves_like "followable"
  it { expect(Story).to have_constant(:NAME_MAX_LENGTH) }
  it { expect(Story).to have_constant(:DESCRIPTION_MAX_LENGTH) }

  context 'Associations' do
    it { should belong_to(:user) }
    it { should have_and_belong_to_many(:story_points) }
    it { should have_many(:likes) }
  end

  context 'Validations' do
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:name) }
    it { should validate_length_of(:name).is_at_most(Story::NAME_MAX_LENGTH) }
    it { should validate_length_of(:description).is_at_most(Story::DESCRIPTION_MAX_LENGTH) }
    it { should validate_inclusion_of(:discoverable).in_array([true, false]) }
  end
end
