require 'rails_helper'

RSpec.describe Following, type: :model do
  before do
    allow(CreateOwnerNotificationsService).to receive(:call)
    allow(CreateFollowerNotificationsService).to receive(:call)
  end

  context 'Associations' do
    before do
      subject.user = create(:user)
    end

    it { should belong_to(:user) }
    it { should belong_to(:followable) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:followable_id, :followable_type) }
  end

  context 'Custom validation' do
    let(:user) { create(:user) }
    let(:another_user) { create(:user) }
    let(:invalid_following) { Following.new(user: user, followable: user) }
    let(:valid_following) { Following.new(user: user, followable: another_user) }

    it { expect(invalid_following).not_to be_valid }
    it { expect(valid_following).to be_valid }

    it 'should include error message' do
      invalid_following.valid?
      expect(invalid_following.errors.messages).to include(followable: [I18n.t('following.following_errors')])
    end
  end

  it_behaves_like 'notificable'
end
