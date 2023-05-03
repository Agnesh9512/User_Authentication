class User < ApplicationRecord
  rolify
  enum role: [:newuser, :admin]
  extend FriendlyId
  friendly_id :name, use: :slugged
  # Include default devise modules. Others available are:
  # :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :confirmable, :lockable

  # after_create :assign_default_role

  after_initialize do
    if new_record?
      self.role ||= :newuser
    end
  end

  validate :must_have_a_role, on: :update

  private

  def must_have_a_role
    return if roles.any?

    errors.add(:roles, 'must have at least 1 role')
  end

  # def assign_default_role
  #   self.add_role(:newuser) if self.roles.blank?
  # end

end
