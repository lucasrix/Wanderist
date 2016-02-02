require 'rails_helper'

RSpec.describe StoryPoint, type: :model do
  context 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:story) }
    it { is_expected.to have_one(:content) }
    it { is_expected.to have_many(:reports) }
    it { is_expected.to have_and_belong_to_many(:tags) }
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of(:latitude) }
    it { is_expected.to validate_presence_of(:longitude) }
  end
end

