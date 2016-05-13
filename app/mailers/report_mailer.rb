class ReportMailer < ActionMailer::Base
  default from: 'report@maplifyapp.com'

  def new_report(report)
    @report = report
    @reportable = @report.reportable
    @report_from = @report.user
    mail(to: ENV['ADMIN_EMAIL'], subject: I18n.t(:new_report_subject, scope: [:mailer, :report]))
  end
end

