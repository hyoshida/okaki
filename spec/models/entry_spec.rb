require 'rails_helper'

RSpec.describe Entry, type: :model do
  subject { build(:entry) }

  describe '#content' do
    context 'doruby entry' do
      before { subject.doruby = true }
      it { expect(subject.content).to eq(subject.body) }
    end

    context 'new type entry' do
      before { subject.doruby = false }

      it 'decorates by .markdown' do
        expect(subject.class).to receive(:markdown).with(subject.body)
        subject.content
      end
    end
  end

  describe '#views_count' do
    it { expect(subject.views_count).to eq(subject.impressions_count) }
  end

  describe '#eye_catch_image_url' do
    context 'it has no image' do
      before { subject.image = nil }
      it { expect(subject.eye_catch_image_url).to eq('noimage.png') }
    end

    context 'it has a image' do
      before { subject.image = Rack::Test::UploadedFile.new(Rails.root.join('public/favicon.ico')) }
      it { expect(subject.eye_catch_image_url).to eq(subject.image_url) }
    end
  end

  describe '#as_json' do
    it 'has id' do
      subject.id = 1
      expect(subject.as_json[:id]).to eq(subject.id)
    end

    it 'has text' do
      subject.title = 'title'
      expect(subject.as_json[:text]).to eq(subject.title)
    end
  end

  describe '#generate_slug' do
    context 'title includes a upper letter' do
      before { subject.title = 'Sample' }
      it { expect { subject.send(:generate_slug) }.to change { subject.slug }.to('Sample') }
    end

    context 'title includes Japanese' do
      before { subject.title = 'ローマ人の物語(1)' }
      it { expect { subject.send(:generate_slug) }.to change { subject.slug }.to('ローマ人の物語(1)') }
    end

    context 'title includes the unsafe letters' do
      before { subject.title = ".!~*';/#?:@&=+$,[] " }
      it { expect { subject.send(:generate_slug) }.to change { subject.slug }.to('-------------------') }
    end
  end
end
