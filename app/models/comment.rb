class Comment < ActiveRecord::Base
  include Voteable
  include Rankable
  include Notifiable
  include Markdownable

  NOTIFICATION_MESSAGE = "Someone replied to your comment."

  belongs_to :post
  belongs_to :user
  belongs_to :parent, polymorphic: true
  has_many   :comments, as: :parent
  has_many   :notifications, as: :notifiable

  validates :content, presence: true

  scope :ranked, -> { all.sort_by(&:ranking).reverse }
  scope :root, -> { where('post_id = parent_id') }
end
