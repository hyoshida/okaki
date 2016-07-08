require 'rails_helper'

RSpec.describe Page, type: :model do
  subject { build(:page) }

  describe '#normalize_slug' do
    context 'argument is empty' do
      it { expect(subject.normalize_slug('')).to eq(subject.send(:default_slug)) }
    end

    context 'argument is present' do
      it { expect(subject.normalize_slug('sample')).to eq('sample') }
    end
  end

  describe '#default_slug' do
    context 'there are no records' do
      it { expect(subject.send(:default_slug)).to eq('pages_1') }
    end

    context 'there are some records' do
      before { subject.save! }
      it { expect(subject.send(:default_slug)).to eq("pages_#{subject.id.next}") }
    end
  end
end
