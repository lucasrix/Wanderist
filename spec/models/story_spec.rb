require 'rails_helper'

RSpec.describe Story, type: :model do
  context 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to have_many(:reports) }
    it { is_expected.to have_many(:story_relationships) }

    it do
      is_expected.to have_many(:followers).through(:story_relationships)
        .source(:user)
    end

    it { is_expected.to have_and_belong_to_many(:story_points) }
  end

  context 'Validations' do
    it { is_expected.to validate_presence_of(:name) }
  end
end
