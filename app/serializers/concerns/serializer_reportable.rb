require 'active_support/concern'

module SerializerReportable
  extend ActiveSupport::Concern

  included { attributes :reported }

  def reported
    object.reported?(scope)
  end
end
