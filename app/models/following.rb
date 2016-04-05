class Following < ActiveRecord::Base
  belongs_to :user
  belongs_to :followable, polymorphic: true
  validates_uniqueness_of :user_id, scope: [:followable_id, :followable_type]
  validate :following_himself

  private

    def following_himself
      errors.add(:followable, I18n.t('following.following_errors')) if self.user.equal?(followable)
    end
end
