require 'rails_helper'

RSpec.describe StoryPoint, type: :model do
  it { expect(StoryPoint).to have_constant(:CAPTION_MAX_LENGTH) }
  it { expect(StoryPoint).to have_constant(:TEXT_MAX_LENGTH) }

  context 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:location) }
    it { should belong_to(:attachment) }
    it { should have_and_belong_to_many(:tags) }
    it { should have_and_belong_to_many(:stories) }
    it { should have_many(:likes) }

  end

  context 'Validations' do
    it { should validate_presence_of(:caption) }
    it { should validate_length_of(:caption).is_at_most(StoryPoint::CAPTION_MAX_LENGTH) }
    it { should validate_presence_of(:text) }
    it { should validate_length_of(:text).is_at_most(StoryPoint::TEXT_MAX_LENGTH) }
    it { should validate_presence_of(:user) }
    it { should validate_presence_of(:location) }
    it { should validate_presence_of(:kind) }
    it { should validate_presence_of(:attachment) }
  end
end

