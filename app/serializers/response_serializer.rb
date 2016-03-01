class ResponseSerializer < ApplicationSerializer
  self.root = false

  attributes :status, :data, :error

  def attributes
    hash = super
    hash.each do |key, value|
      if value.nil? or (value.is_a?(Hash) and value.empty?)
        hash.delete(key)
      end
    end
    hash
  end
end