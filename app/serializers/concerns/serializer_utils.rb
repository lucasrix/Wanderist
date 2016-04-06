require 'active_support/concern'

module SerializerUtils
  extend ActiveSupport::Concern

  included do
    attributes :type
  end

  def type
    object.class.name
  end
end
