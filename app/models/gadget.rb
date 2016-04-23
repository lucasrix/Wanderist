class Gadget < ActiveRecord::Base
  belongs_to :user

  validates :token, presence: true, length: { is: 73 }
end
