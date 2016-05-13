class Report < ActiveRecord::Base
  REPORT_KIND = %w(dislike spam risk unsuited)

  has_secure_token :action_token

  belongs_to :user
  belongs_to :reportable, polymorphic: true

  validates :reportable_id, :reportable_type, presence: true
  validates :user_id, presence: true, uniqueness: { scope: [:reportable_id, :reportable_type] }
  validates :kind, presence: true, inclusion: REPORT_KIND

  after_create { ReportEmailJob.perform_later(self.id) }
end
