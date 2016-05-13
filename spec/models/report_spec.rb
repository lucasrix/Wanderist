require 'rails_helper'

RSpec.describe Report, type: :model do
  before do
    subject.user = create(:user)
    allow(ReportEmailJob).to receive(:perform_later)
  end

  context 'Associations' do
    it { should belong_to(:reportable) }
  end

  context 'Validations' do
    it { should validate_presence_of(:user_id) }
    it { should validate_uniqueness_of(:user_id).scoped_to(:reportable_id, :reportable_type) }
    it { should validate_presence_of(:reportable_id) }
    it { should validate_presence_of(:reportable_type) }
    it { should validate_presence_of(:kind) }
    it { should validate_inclusion_of(:kind).in_array(Report::REPORT_KIND) }
  end

  describe '.after_create' do
    it 'creates new delayed job' do
      expect(ReportEmailJob).to receive(:perform_later)
      create(:report, reportable: create(:story), user: subject.user)
    end
  end
end
