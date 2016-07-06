require 'rails_helper'

RSpec.describe User, type: :model do
  subject { build(:user) }

  describe '#nickname' do
    context 'nickname is empty' do
      it { expect(subject.nickname).to eq(subject.name) }
    end

    context 'nickname is present' do
      before { subject.update(nickname: 'Julius Caesar') }
      it { expect(subject.nickname).to eq('Julius Caesar') }
    end
  end

  describe '#generate_name' do
    it 'generates name from email' do
      subject.email = "john@example.com"
      subject.send(:generate_name)
      expect(subject.name).to eq('john')
    end
  end
end
