require 'rails_helper'

RSpec.describe "entries/index", type: :view do
  let(:user) { build(:user) }

  before(:each) do
    assign(:user, user)
    assign(:entries, [
      create(:entry, user: user),
      create(:entry, user: user)
    ])
  end

  it "renders a list of entries" do
    render
  end
end
