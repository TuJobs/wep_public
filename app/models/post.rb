class Post < ApplicationRecord
  belongs_to :user

  scope :post_sort, ->{order created_at: :desc}
  scope :load_feed, ->(id, following_ids) do
    where "user_id IN (#{following_ids}) OR user_id = :user_id",
      following_ids: following_ids, user_id: id
  end

  mount_uploader :picture, PictureUploader

  validates :user_id, presence: true
  validates :content, presence: true, length: {maximum: Settings.post.max_str}
  validate  :picture_size

  private

  def picture_size
    if picture.size > Settings.picture.size.megabytes
      errors.add :picture, I18n.t(".limit_picture")
    end
  end
end
