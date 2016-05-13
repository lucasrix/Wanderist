require 'rails_helper'

RSpec.describe Notification, type: :model do
  context 'Associations' do
    before do
      subject.user = create(:user)
    end

    it { should belong_to(:user) }
    it { should belong_to(:notificable) }
    it { should validate_presence_of(:message) }
    it { should validate_presence_of(:user_id) }
    it { should validate_presence_of(:notificable_id) }
    it { should validate_presence_of(:notificable_type) }
  end
end
