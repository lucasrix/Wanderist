require 'rails_helper'

RSpec.describe Tag, type: :model do
  context 'Associations' do
    it { is_expected.to have_and_belong_to_many(:story_points) }
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
