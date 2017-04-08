require File.join(File.dirname(__FILE__), '..', 'spec_helper')

RSpec.describe Image, type: :model do
  describe 'Associations' do
    let(:image) { build(:image) }
    subject { image }
    it { is_expected.to have_many(:tags) }
  end
end
