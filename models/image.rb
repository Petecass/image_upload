class Image < ActiveRecord::Base
  include Paperclip::Glue

  has_many :taggings
  has_many :tags, through: :taggings, dependent: :destroy

  validates :title, presence: true

  has_attached_file :image,
                    # Using bang ignores aspect ratio
                    styles: { square: '1000x1000!',
                              thumb: '50x50!',
                              greyscale: { convert_options: '-colorspace Gray' } },
                    storage: :s3,
                    s3_protocol: 'https',
                    s3_region: ENV['AWS_REGION'],
                    s3_host_name: ENV['AWS_HOST_NAME'],
                    s3_credentials: { access_key_id: ENV['AWS_ACCESS_KEY_ID'],
                                      secret_access_key: ENV['AWS_SECRET_ACCESS_KEY'] },
                    bucket: ENV['S3_BUCKET']

  validates_attachment :image,
                       content_type: { content_type: ['image/jpeg', 'image/jpg', 'image/png'] }

  # Overides default #to_json method
  def as_json(options = {})
    super({
      only: [:id, :title, :author],
      include: { tags: { only: [:id, :name] } },
      methods: [:thumbnail, :square, :greyscale]
    }.merge(options))
  end

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

  private

  def thumbnail
    image.url(:thumb)
  end

  def square
    image.url(:square)
  end

  def greyscale
    image.url(:greyscale)
  end
end
