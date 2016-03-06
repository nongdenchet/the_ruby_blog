require 'rails_helper'

describe "the signin process", type: :feature, js: true do
  before :each do
    create(:user)
  end

  it "signs me in" do
    visit '/users/sign_in'
    fill_in 'Email', :with => 'vuhuyquan@apidez.com'
    fill_in 'Password', :with => 'androidDeveloper7'
    click_button 'Log In'
    expect(page).to have_content 'There is no article'
  end
end