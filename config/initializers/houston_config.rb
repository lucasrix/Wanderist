if Rails.env.development? || Rails.env.test?
  APN = Houston::Client.development
  APN.certificate = File.read(Rails.root.join('config', 'keys', 'pushcert_development.pem').to_s)
end

