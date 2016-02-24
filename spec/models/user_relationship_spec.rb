require 'rails_helper'

RSpec.describe UserRelationship, type: :model do
  context 'Associations' do
    it { is_expected.to belong_to(:follower).class_name(User.name) }
    it { is_expected.to belong_to(:followed).class_name(User.name) }
  end
end
