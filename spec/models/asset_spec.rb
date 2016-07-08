require 'rails_helper'

RSpec.describe Asset, type: :model do
  subject { build(:asset) }

  describe '#image?' do
    context 'it is *.jpeg file' do
      before { allow(subject).to receive(:file_url).and_return('sample.jpeg') }
      it { expect(subject).to be_image }
    end

    context 'it is *.jpg file' do
      before { allow(subject).to receive(:file_url).and_return('sample.jpg') }
      it { expect(subject).to be_image }
    end

    context 'it is *.png file' do
      before { allow(subject).to receive(:file_url).and_return('sample.png') }
      it { expect(subject).to be_image }
    end

    context 'it is *.gif file' do
      before { allow(subject).to receive(:file_url).and_return('sample.gif') }
      it { expect(subject).to be_image }
    end
  end

  describe '#filename' do
    before { allow(subject).to receive(:file_url).and_return('path/to/file.png') }
    it { expect(subject.filename).to eq('file.png') }
  end

  describe '#file_size' do
    before { allow(subject).to receive(:file).and_return(OpenStruct.new(size: 123)) }
    it { expect(subject.file_size).to eq(subject.file.size) }
  end

  describe '#to_jquery_upload' do
    it { expect(subject.to_jquery_upload[:name]).to eq(subject[:file]) }
    it { expect(subject.to_jquery_upload[:size]).to eq(subject.file.size) }
    it { expect(subject.to_jquery_upload[:url]).to eq(subject.file.url) }
  end

  describe '#doruby?' do
    context 'doruby asset' do
      before { subject.original_filename = 'file.png' }
      it { expect(subject).to be_doruby }
    end

    context 'new type asset' do
      before { subject.original_filename = nil }
      it { expect(subject).not_to be_doruby }
    end
  end

  describe '#set_title' do
    context 'it is a new asset' do
      before { allow(subject.file).to receive(:original_filename).and_return('file.png') }
      it { expect { subject.send(:set_title) }.to change { subject.title }.to('file') }
    end

    context 'it is a persistent asset' do
      before { subject.save! }
      it { expect { subject.send(:set_title) }.not_to change { subject.title } }
    end
  end
end
