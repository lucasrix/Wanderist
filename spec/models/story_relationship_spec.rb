require 'rails_helper'

RSpec.describe StoryRelationship, type: :model do
  context 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:story) }
  end
end
