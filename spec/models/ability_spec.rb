require 'rails_helper'
require 'cancan/matchers'

RSpec.describe Ability, type: :model do
  let(:user) { create(:user) }
  let(:another_user) { create(:user) }

  subject { Ability.new(user) }

  context 'story points' do
    let(:story_point) { build(:story_point, user: user) }
    let(:foreign_story_point) { build(:story_point, user: another_user) }


    describe 'create' do
      it { should be_able_to(:create, story_point) }
      it { should_not be_able_to(:create, foreign_story_point) }
    end

    describe 'read' do
      it { should be_able_to(:read, story_point) }
      it { should_not be_able_to(:read, foreign_story_point) }
    end


  end

end