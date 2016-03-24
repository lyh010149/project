class Collection < ActiveRecord::Base
  belongs_to :collecter, class_name: "User"
  belongs_to :collected, class_name: "Micropost"
  validates :collecter_id, presence: true
  validates :collected_id, presence: true
end
