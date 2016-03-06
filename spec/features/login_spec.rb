require 'rails_helper'

describe "the signin process", type: :feature, js: true do
  before :each do
    create(:user)
  end

  it "login successfully" do
    visit '/users/sign_in'
    fill_in 'Email', :with => 'vuhuyquan@apidez.com'
    fill_in 'Password', :with => 'androidDeveloper7'
    click_button 'Log In'
    expect(page).to have_content 'Signed in successfully.'
    expect(page).to have_content 'There is no article'
  end

  it "login fail" do
    visit '/users/sign_in'
    fill_in 'Email', :with => 'vuhuyquan@apidez.com'
    fill_in 'Password', :with => 'android'
    click_button 'Log In'
    expect(page).to have_content 'Invalid email or password.'
    expect(page).not_to have_content 'There is no article'
  end

  it "should open login page" do
    visit '/'
    find_link('Log In').click
    find_button('Log In')
  end
end