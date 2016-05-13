require 'rails_helper'

RSpec.describe Like, type: :model do

  before do
    subject.user = create(:user)
    allow(CreateOwnerNotificationsService).to receive(:call)
    allow(CreateFollowerNotificationsService).to receive(:call)
  end

  context 'Associations' do

    it { should belong_to(:user) }
    it { should belong_to(:likable) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:likable_id, :likable_type) }
  end

  it_behaves_like 'notificable'
end
