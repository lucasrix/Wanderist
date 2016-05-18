class ReportEmailJob < ActiveJob::Base
  queue_as :email_notifications

  def perform(report_id)
    report = Report.find(report_id)
    ReportMailer.new_report(report).deliver_now
  end
end
