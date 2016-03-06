require 'rails_helper'

describe "the sign-up process", type: :feature, js: true do
  before :each do
    create(:user)
  end

  it "should open sign-up page" do
    visit '/'
    find_link('Sign Up').click
    find_button('Sign up')
  end
end