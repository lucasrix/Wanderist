require "yaml"

app_config = YAML.load_file('config/application.yml')
db_config  = YAML.load_file('config/database.yml')

Model.new(:maplifyapp_db_backup, 'Backup of Maplifyapp postgresql db') do
  database PostgreSQL do |db|
    db.name               = db_config['production']['database']
    db.username           = db_config['production']['username']
    db.password           = db_config['production']['password']
    db.host               = "localhost"
    db.port               = 5432
    db.socket             = "/var/run/postgresql/"
    db.additional_options = ["-xc", "-E=utf8"]
  end

  store_with S3 do |s3|
    s3.access_key_id     = app_config['AWS_ACCESS_KEY_ID']
    s3.secret_access_key = app_config['AWS_SECRET_ACCESS_KEY']
    s3.bucket            = app_config['AWS_BACKUP_BUCKET']
    s3.path              = "production"

    s3.keep              = 30 # store 30 last backups

    s3.max_retries   = 10
    s3.retry_waitsec = 30
  end

  compress_with Gzip

  notify_by Mail do |mail|
    mail.on_success           = true
    mail.on_warning           = true
    mail.on_failure           = true

    mail.from                 = app_config['BACKUP_NOTIFICATION_FROM']
    mail.to                   = app_config['BACKUP_NOTIFICATION_TO']
    mail.address              = "smtp.sendgrid.net"
    mail.port                 = 587
    mail.domain               = app_config['DOMAIN_NAME']
    mail.user_name            = app_config['SENDGRID_USERNAME']
    mail.password             = app_config['SENDGRID_PASSWORD']
    mail.authentication       = "plain"
    mail.encryption           = :starttls
  end
end

Logger.configure do
  # Console options:
  console.quiet = false

  # Logfile options:
  logfile.enabled   = true
  logfile.log_path  = 'log'
  logfile.max_bytes = 500_000

  # Syslog options:
  syslog.enabled  = false
  syslog.ident    = 'backup-maplifyapp'
  syslog.options  = Syslog::LOG_PID
  syslog.facility = Syslog::LOG_LOCAL0
  syslog.info     = Syslog::LOG_INFO
  syslog.warn     = Syslog::LOG_WARNING
  syslog.error    = Syslog::LOG_ERR
end
