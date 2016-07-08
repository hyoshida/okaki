require 'rails_helper'

RSpec.describe Advertisement, type: :model do
  subject { build(:advertisement) }

  describe '#title' do
    context 'title is nil' do
      before { subject.title = nil }
      it { expect(subject.title).to be }
    end
  end
end
