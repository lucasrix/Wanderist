class ReportMailer < ActionMailer::Base
  default from: 'report@maplifyapp.com'

  def new_report(report)
    @report = report
    @reportable = @report.reportable
    @report_from = @report.user
    @link = build_link
    mail(to: ENV['ADMIN_EMAIL'], subject: I18n.t(:new_report_subject, scope: [:mailer, :report]))
  end

  def build_link
    URI::Generic.new("maplify", nil, 'share?', nil, nil, query, nil, nil, nil)
  end

  def query
    { type: @reportable.class.name, id: @reportable.id }.to_query
  end
end
