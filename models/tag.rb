class Tag < ActiveRecord::Base
  has_many :taggings
  has_many :images, through: :taggings, dependent: :destroy

  validates :name, presence: true
end
