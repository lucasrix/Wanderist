task :backup_db => :environment do
  Bundler.with_clean_env do
    sh "backup perform -t maplifyapp_db_backup -c config/backup/config.rb"
  end
end
