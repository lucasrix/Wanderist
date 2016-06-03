class UserNotificationMailer < ActionMailer::Base
  include Attachmentable

  default from: ENV["NO_REPLAY_EMAIL"]

  def welcome(user)
    set_attachments
    mail(to: user.email, subject: I18n.t(:welcome_subject, scope: [:mailer, :welcome]))
  end
end
