require 'rails_helper'

RSpec.describe Blog, type: :model do
  subject { build(:blog) }

  describe '.instance' do
    it 'is singleton' do
      expect(described_class.instance.attributes).to eq(described_class.instance.attributes)
    end

    it 'has default title' do
      expect(described_class.instance.title).to be_present
    end
  end

  describe '.new' do
    it 'cannot calls' do
      expect { described_class.new }.to raise_error(NoMethodError)
    end
  end
end
