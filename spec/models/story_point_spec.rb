require 'rails_helper'

RSpec.describe StoryPoint, type: :model do
  context 'Associations' do
    it { should belong_to(:user) }
    it { should belong_to(:story) }
  end

  context 'Validations' do
    it { should validate_presence_of(:caption) }
    it { should validate_presence_of(:user_id) }
  end
end

