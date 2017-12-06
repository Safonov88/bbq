class Photo < ApplicationRecord
  belongs_to :event
  belongs_to :user

  validates :event, presence: true
  validates :user, presence: true
  validate :photo_is_blank?

  mount_uploader :photo, PhotoUploader

  scope :persisted, -> {where "id IS NOT NULL"}

  def photo_is_blank?
    if photo.blank?
      errors.add(:photo, :photo_blank)
    end
  end
end
