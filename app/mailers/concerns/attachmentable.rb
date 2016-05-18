module Attachmentable
  extend ActiveSupport::Concern

  def set_attachments
    attachments.inline['email_maplify_logo.png'] = File.read('public/email_maplify_logo.png')
    attachments.inline['email_fb.png'] = File.read('public/email_fb.png')
    attachments.inline['email_instagram.png'] = File.read('public/email_instagram.png')
    attachments.inline['email_tw.png'] = File.read('public/email_tw.png')
    attachments.inline['email_yt.png'] = File.read('public/email_yt.png')
  end
end

