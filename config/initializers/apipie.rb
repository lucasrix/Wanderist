Apipie.configure do |config|
  config.app_name = "Wanderist"
  config.copyright = "Wanderist &copy; 2016"
  config.doc_base_url = "/apipie"
  config.api_base_url = "/api"
  config.api_base_url["v1"] = "/api/v1"
  config.disqus_shortname = "maplify" unless Rails.env.development?
  config.validate = Rails.env.development?
  config.markup = Apipie::Markup::Markdown.new
  config.reload_controllers = Rails.env.development?
  config.api_controllers_matcher = File.join(Rails.root, "app", "controllers", "**", "*.rb")
  config.app_info["v1"] = "Wanderist API documentation"
  config.languages = ['en']
  config.default_locale = 'en'
  config.default_version = 'v1'
end
