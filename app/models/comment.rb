class Comment < ActiveRecord::Base
    belongs_to :user
	belongs_to :micropost
	validates :content, presence: true, length: {maximum:200}
	validates :user_id, presence: true
	validates :micropost_id, presence: true

	default_scope -> { order(created_at: :desc) }

end
