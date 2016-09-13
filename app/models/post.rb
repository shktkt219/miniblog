class Post < ActiveRecord::Base
  belongs_to :user
  default_scope { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 200 }

  has_many :post_tags
  has_many :tags, through: :post_tags
  #permit tags to be nested in our new Post form
  accepts_nested_attributes_for :tags, reject_if: proc { |attributes| attributes['name'].blank? }

  has_many :comments, dependent: :destroy
end
