class Micropost < ActiveRecord::Base
  belongs_to :user
  has_many :collections, foreign_key: "collected_id",
                         dependent:   :destroy
  has_many :collecters, through: :collections, source: :collecter
  has_many :comments, dependent: :destroy
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 900 }
  validates :name, presence: true, length: { maximum: 400 }
  default_scope -> { order(created_at: :desc) }
  mount_uploader :picture, PictureUploader
  validate  :picture_size

  private

    # Validates the size of an uploaded picture.
    def picture_size
      if picture.size > 5.megabytes
        errors.add(:picture, "should be less than 5MB")
      end
    end

    def self.search(query)
    # where(:title, query) -> This would return an exact match of the query
    where("name like ? OR content like ?", "%#{query}%", "%#{query}%")
  end
end
