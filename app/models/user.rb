class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable, :registerable, :recoverable, :rememberable, :validatable

  has_many :events
  has_many :comments
  has_many :subscriptions

  validates :name, presence: true, length:  {maximum: 35}
  before_validation :set_name, on: :create

  after_commit :link_subscriptions, on: :create
  private

  def set_name
    self.name = "Товарищ № #{rand(777)}" if self.name.blank?
  end

  def link_subscription
    Subscription.where(user_id: nil, user_email: user.email).update_all(user_id: self.id)
  end
end
