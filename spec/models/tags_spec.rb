require File.join(File.dirname(__FILE__), '..', 'spec_helper')

RSpec.describe Tag, type: :model do
  describe 'Associations' do
    let(:tag) { build(:tag) }
    subject { tag }

    it { is_expected.to have_many(:images).through(:taggings).dependent(:destroy) }
  end

  describe 'Validations' do
    let(:tag) { build(:tag) }
    subject { tag }

    it { is_expected.to validate_presence_of(:name) }
  end
end
