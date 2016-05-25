if Rails.env.development? || Rails.env.test?
  APN = Houston::Client.development
  path = File.join(Rails.root, 'config', 'keys', 'pushcert_development.pem')
else
  APN = Houston::Client.production
  path = File.join(Rails.root, 'config', 'keys', 'pushcert_production.pem')
end

APN.certificate = File.read(path) if File.exists?(path)

