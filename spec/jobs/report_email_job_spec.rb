require 'rails_helper'

RSpec.describe ReportEmailJob, type: :job do
  let(:report) { create(:report, reportable: create(:story), user: create(:user)) }

  it 'sends email' do
    allow(ReportMailer).to receive_message_chain(:new_report, :deliver_now)
    expect(ReportMailer).to receive_message_chain(:new_report, :deliver_now)
    ReportEmailJob.perform_later(report.id)
  end
end
