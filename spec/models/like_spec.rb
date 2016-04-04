require 'rails_helper'

RSpec.describe Like, type: :model do
  context 'Associations' do
    before do
      subject.user = create(:user)
    end

    it { should belong_to(:user) }
    it { should belong_to(:likable) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:likable_id, :likable_type) }
  end
end
