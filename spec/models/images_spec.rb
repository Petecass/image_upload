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
    let(:image) { build(:image, :with_attachment) }

    it 'creates variations of the image' do
      image.save
      image.reload
      expect(image.image.url(:square)).to be
      expect(image.image.url(:original)).to be
      expect(image.image.url(:greyscale)).to be
      expect(image.image.url(:thumb)).to be
    end
  end
end
