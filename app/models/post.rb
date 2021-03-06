class Post < ApplicationRecord
  validates :text, :image, presence: true

  belongs_to :user
  has_many :comments
  has_many :post_tags
  has_many :tags, through: :post_tags
  mount_uploader :image, ImageUploader

  def save_posts(tags)
    current_tags = self.tags.pluck(:tagname) unless self.tags.nil?
    old_tags = current_tags - tags
    new_tags = tags - current_tags
  
    old_tags.each do |old_name|
      self.tags.delete Tag.find_by(tagname:old_name)
    end

    new_tags.each do |new_name|
      post_tag = Tag.find_or_create_by(tagname:new_name)
      self.tags << post_tag
    end
  end
end