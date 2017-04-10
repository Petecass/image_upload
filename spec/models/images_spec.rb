require File.join(File.dirname(__FILE__), '..', 'spec_helper')

RSpec.describe Image, type: :model do
  describe 'Associations' do
    let(:image) { build(:image) }
    subject { image }
    it { is_expected.to have_many(:tags).through(:taggings).dependent(:destroy) }
  end

  describe 'Validations' do
    let(:image) { build(:image) }
    subject { image }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to have_attached_file(:image) }
    it do
      is_expected.to validate_attachment_content_type(:image)
        .allowing('image/png', 'image/jpg')
        .rejecting('text/plain', 'text/xml')
    end
  end

  describe 'Image Processing' do
    let(:image) { create(:image, :with_attachment) }

    it 'creates variations of the image and provides url to s3' do
      expect(image.image.url(:square)).to include("https://#{ENV['AWS_HOST_NAME']}/")
      expect(image.image.url(:original)).to include("https://#{ENV['AWS_HOST_NAME']}/")
      expect(image.image.url(:greyscale)).to include("https://#{ENV['AWS_HOST_NAME']}/")
      expect(image.image.url(:thumb)).to include("https://#{ENV['AWS_HOST_NAME']}/")
    end
  end
end
