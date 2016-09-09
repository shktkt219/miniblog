class Post < ActiveRecord::Base
  belongs_to :user
  default_scope { order(created_at: :desc) }
  validates :user_id, presence: true
  validates :content, presence: true, length: { maximum: 200 }

  has_many :post_tags
  has_many :tags, through: :post_tags
  accepts_nested_attributes_for :tags

  def tags_attributes=(tag_attributes)
    tag_attributes.values.each do |tag_attribute|
      tag = Tag.find_or_create_by(tag_attribute)
      self.tags << tag
    end
  end
end
