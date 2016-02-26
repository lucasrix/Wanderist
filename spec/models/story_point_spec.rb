require 'rails_helper'

RSpec.describe StoryPoint, type: :model do
  context 'Associations' do
    it { should belong_to(:user) }
    it { should have_many(:reports) }
    it { should have_many(:likes) }
    it { should have_many(:liking_users).through(:likes).source(:user) }
    it { should have_and_belong_to_many(:tags) }
    it { should have_and_belong_to_many(:stories) }
  end

  context 'Validations' do
    it { should validate_presence_of(:latitude) }
    it { should validate_presence_of(:longitude) }
  end
end

