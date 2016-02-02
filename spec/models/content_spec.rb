require 'rails_helper'

RSpec.describe Content, type: :model do
  context 'Associations' do
    it { is_expected.to belong_to(:story_point) }
    it { is_expected.to belong_to(:entity) }
  end
end
