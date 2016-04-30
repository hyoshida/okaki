require 'rails_helper'

RSpec.describe "entries/edit", type: :view do
  let(:user) { entry.user }
  let(:entry) { create(:entry) }

  before(:each) do
    assign(:entry, entry)
    assign(:user, user)
  end

  it "renders the edit entry form" do
    render

    assert_select "form[action=?][method=?]", user_entry_path(user, entry), "post" do
    end
  end
end
