require 'rails_helper'

RSpec.describe Tracker, type: :model do
  subject { build(:tracker) }

  describe '.cache_key' do
    it 'has timestamp' do
      subject.save!
      timestamp = described_class.maximum(:updated_at)
      expect(described_class.cache_key).to match(/#{timestamp.year}.*#{timestamp.month}.*#{timestamp.day}/)
    end

    it 'has record count' do
      subject.save!
      count = described_class.count
      expect(described_class.cache_key).to match(count.to_s)
    end

    context 'search with location' do
      it { expect(described_class.where(location: 'head').cache_key).to match('head') }
    end
  end
end
