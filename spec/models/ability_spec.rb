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

    describe 'update' do
      it { should be_able_to(:update, story_point) }
      it { should_not be_able_to(:update, foreign_story_point) }
    end

    describe 'read' do
      it { should be_able_to(:read, story_point) }
      it { should_not be_able_to(:read, foreign_story_point) }
    end

    describe 'destroy' do
      it { should be_able_to(:destroy, story_point) }
      it { should_not be_able_to(:destroy, foreign_story_point) }
    end

  end

  context 'attachment' do
    let(:attachment) { build(:attachment, user: user) }
    let(:foreign_attachment) { build(:attachment, user: another_user) }

    describe 'read' do
      it { should be_able_to(:read, attachment) }
      it { should_not be_able_to(:read, foreign_attachment) }
    end

    describe 'create' do
      it { should be_able_to(:create, attachment) }
      it { should_not be_able_to(:create, foreign_attachment) }
    end
  end

  context 'story' do
    let(:story) { build(:story, user: user) }
    let(:foreign_story) { build(:story, user: another_user) }

    describe 'read' do
      it { should be_able_to(:read, story) }
      it { should_not be_able_to(:read, foreign_story) }
    end
  end

end