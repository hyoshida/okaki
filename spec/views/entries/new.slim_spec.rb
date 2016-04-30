require 'rails_helper'

RSpec.describe "entries/new", type: :view do
  let(:user) { entry.user }
  let(:entry) { build(:entry) }

  before(:each) do
    assign(:user, user)
    assign(:entry, entry)
  end

  it "renders new entry form" do
    render

    assert_select "form[action=?][method=?]", user_entries_path(user), "post" do
    end
  end
end
