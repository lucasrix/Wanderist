if Rails.env.development? || Rails.env.test?
  APN = Houston::Client.development
  APN.certificate = File.read(Rails.root.join('tmp', 'certs', 'pushcert.pem').to_s)
end

