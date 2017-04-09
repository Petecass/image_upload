class Image < ActiveRecord::Base
  has_many :taggings
  has_many :tags, through: :taggings

  validates :title, presence: true

  def all_tags=(names)
    self.tags = names.split(',').map do |name|
      Tag.where(name: name.strip.downcase).first_or_create!
    end
  end

  def all_tags
    tags.map(&:name).join(', ')
  end

  def self.tagged_with(name)
    Tag.find_by(name: name).images
  end
end
