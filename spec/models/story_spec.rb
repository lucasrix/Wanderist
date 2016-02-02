require 'rails_helper'

RSpec.describe Story, type: :model do
  context 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:story_points) }
    it { is_expected.to have_many(:reports) }
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
