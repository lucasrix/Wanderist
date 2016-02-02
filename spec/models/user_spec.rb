require 'rails_helper'

RSpec.describe User, type: :model do
  context 'Associations' do
    it { is_expected.to have_one(:settings_suit) }
    it { is_expected.to have_many(:stories) }
    it { is_expected.to have_many(:story_points) }
  end

  context 'Validations' do
    subject { build(:user) }
    it { is_expected.to validate_presence_of(:username) }
    it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
  end
end
