require 'rails_helper'

RSpec.describe Like, type: :model do
  context 'Associations' do
    it { is_expected.to belong_to(:user) }
    it { is_expected.to belong_to(:story_point) }
  end
end
