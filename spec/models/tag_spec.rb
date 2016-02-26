require 'rails_helper'

RSpec.describe Tag, type: :model do
  context 'Associations' do
    it { should have_and_belong_to_many(:story_points) }
  end

  context 'Validations' do
    it { should validate_presence_of(:name) }
  end
end
