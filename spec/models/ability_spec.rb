require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  let(:user) { create(:user) }
  subject { Ability.new(user) }

  it { should be_able_to(:create, StoryPoint, user_id: user.id) }
end