class ErrorSerializer < ActiveModel::Serializer
  attributes :error_messages, :details
end