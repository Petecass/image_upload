require File.join(File.dirname(__FILE__), '..', 'spec_helper')

RSpec.describe Tag, type: :model do
  describe 'Associations' do
    let(:tag) { build(:tag) }
    subject { tag }

    it { is_expected.to belong_to(:image) }
  end
end
