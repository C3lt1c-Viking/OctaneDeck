class Micropost < ApplicationRecord
  belongs_to :user
  has_many :comments, as: :commentable
  has_one_attached :image do |attachable|
    attachable.variant :display, resize_to_limit: [500, 500]
  end
  default_scope -> { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 3500 }
  validates :image,   content_type: { in: %w[image/jpeg image/gif image/png image/jpg image/eps image/ai image/pdf image/gif image/tiff image/psd image/eps image/indd image/raw],
                                      message: "must be a valid image format" },
                      size:         { less_than: 250000.megabytes,
                                      message:   "should be less than 250000MB" }

                                      def extension_whitelist
                                        %w(jpg jpeg gif png)
                                      end
end
