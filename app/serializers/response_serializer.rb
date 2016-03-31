class ResponseSerializer < ApplicationSerializer
  self.root = false

  attributes :status, :data, :error

end
