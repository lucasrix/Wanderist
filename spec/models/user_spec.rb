require 'rails_helper'

RSpec.describe User, type: :model do
  it_behaves_like 'followable'
  context 'relations' do
    it { should have_one(:profile).dependent(:destroy) }
    it { should have_many(:stories) }
    it { should have_many(:story_points) }
    it { should have_many(:likes) }
  end

  context 'Validations' do
    subject { build(:user) }
    # it { should validate_presence_of(:username) }
    # it { should validate_uniqueness_of(:username).case_insensitive }
  end

  context 'callbacks' do
    it 'create profile' do
      user = create(:user)
      expect(user.profile).to be_a(Profile)
    end
  end
end
