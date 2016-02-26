require 'rails_helper'

RSpec.describe Story, type: :model do
  context 'Associations' do
    it { should belong_to(:user) }
    it { should have_many(:reports) }
    it { should have_many(:story_relationships) }
    it { should have_many(:followers).through(:story_relationships).source(:user) }
    it { should have_and_belong_to_many(:story_points) }
  end

  context 'Validations' do
    it { should validate_presence_of(:name) }
  end
end
