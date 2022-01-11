require "application_system_test_case"

class UsersTest < ApplicationSystemTestCase

  test "User can views products without signing in" do
    visit root_path
    first(:link, "Show").click
  end

  test "User can register and is redirected to index page" do
    Capybara.reset_sessions!
    visit new_user_registration_path
    assert :success
    fill_in 'Email', with: 'nikola@example.com'
    fill_in 'Password', with: "password"
    fill_in 'Password confirmation', with: "password"
    click_button 'Sign up'
    assert_selector "h1", text: "All Products"
  end

  test "User can login and is redirected to index page" do
    user = User.new(email: 'nikola@example.com', password: "password", password_confirmation: "password")
    user.save!
    Capybara.reset_sessions!
    visit new_user_session_path
    assert :success
    fill_in 'Email', with: 'nikola@example.com'
    fill_in 'Password', with: "password"
    click_button 'Log in'
    assert_selector "h1", text: "All Products"
  end
end
