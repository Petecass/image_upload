require File.join( File.dirname(__FILE__), '..', 'spec_helper')

describe Image do
  describe 'Associations' do
    it { is_expected.to have_many(:tags) }
  end
end
