require 'rails_helper'

RSpec.describe User, type: :model do
  context 'relations' do
    it { should have_one(:profile) }
    it { should have_many(:stories) }
    it { should have_many(:story_points) }
  end

  context 'Validations' do
    subject { build(:user) }
    it { should validate_presence_of(:username) }
    it { should validate_uniqueness_of(:username).case_insensitive }
  end

  context 'callbacks' do
    it 'create profile' do
      user = create(:user)
      expect(user.profile).to be_a(Profile)
    end
  end
end