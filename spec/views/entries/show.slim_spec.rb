require 'rails_helper'

RSpec.describe "entries/show", type: :view do
  let(:user) { entry.user }
  let(:entry) { create(:entry) }

  before(:each) do
    assign(:user, user)
    assign(:entry, entry)
  end

  it "renders attributes in <p>" do
    render
  end
end
