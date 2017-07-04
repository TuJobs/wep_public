class Post < ApplicationRecord
  belongs_to :user
  default_scope -> {order(created_at: :desc)}
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
