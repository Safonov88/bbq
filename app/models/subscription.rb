class Subscription < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :event, presence: true

  validates :user_name, presence: true, unless: 'user.present?'
  validates :user_email, presence: true, format: /\A[a-zA-Z0-9\-_.]+@[a-zA-Z0-9\-_.]+\z/, unless: 'user.present?'

  validates :user, uniqueness: {scope: :event_id}, if: 'user.present?'
  validates :user_email, uniqueness: {scope: :event_id}, unless: 'user.present?'
  validate :email_of_user_present, unless: 'user.present?'
  validate :author_event?

  def user_name
    if user.present?
      user.name
    else
      super
    end
  end

  def user_email
    if user.present?
      user.email
    else
      super
    end
  end

  def email_of_user_present
    if User.find_by(email: user_email)
      errors.add(:user_email, :mail_existing_user)
    end
  end

  def author_event?
    if user.present?
      if event.user == user
        errors.add(:user, :invalid)
      end
    end
  end
end
