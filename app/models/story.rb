class Story < ActiveRecord::Base
  NAME_MAX_LENGTH = 25
  DESCRIPTION_MAX_LENGTH = 512

  belongs_to :user

  validates :name, presence: true
  validates :name,
            presence: true,
            length: {
              maximum: NAME_MAX_LENGTH
            }
  validates :description,
            presence: true,
            length: {
              maximum: DESCRIPTION_MAX_LENGTH
            }
  validates :discoverable, inclusion: { in: [true, false] }

end
