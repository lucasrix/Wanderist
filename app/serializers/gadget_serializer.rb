class GadgetSerializer < ApplicationSerializer
  attributes :id, :token
  has_one :user
end
