require 'rails_helper'

RSpec.describe StoryRelationship, type: :model do
  context 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:story) }
  end
end
