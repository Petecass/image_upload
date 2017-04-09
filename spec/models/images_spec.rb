require File.join(File.dirname(__FILE__), '..', 'spec_helper')

RSpec.describe Image, type: :model do
  describe 'Associations' do
    let(:image) { build(:image) }
    subject { image }
    it { is_expected.to have_many(:tags).through(:taggings) }
  end

  describe 'Validations' do
    let(:image) { build(:image) }
    subject { image }

    it { is_expected.to validate_presence_of(:title) }
  end
end
