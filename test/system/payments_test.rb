require "application_system_test_case"

class PaymentsTest < ApplicationSystemTestCase

  test "Transaction is successful" do
    # User is logged in
    user = User.new(email: 'nikola@example.com', password: "password", password_confirmation: "password")
    user.save!
    Capybara.reset_sessions!
    visit new_user_session_path
    assert :success
    fill_in 'Email', with: 'nikola@example.com'
    fill_in 'Password', with: "password"
    click_button 'Log in'
    assert_selector "h1", text: "All Products"
    
    # Products are added and order details filled
    first(:button, "Add to cart").click
    assert_current_path("/")
    visit carts_path
    click_link 'Pay'
    fill_in 'Address', with: 'Predraga Heruca 15'
    select "Croatia", :from => "Country"
    click_button 'Create Order'
    assert_current_path "/payments/new"

    #Filling in the form
    within_frame('saved-card-component') do
      fill_in 'new-card-pan-input', with: "4111111111111111"
      fill_in 'new_card_transaction_expiry', with: '1232'
      fill_in 'new_card_transaction_cvv', with: '123'
    end

    #Submitting
    click_button 'Submit Payment'
    sleep(2)
    text = page.driver.browser.switch_to.alert.text
    assert_equal text, "Transaction approved"
    page.driver.browser.switch_to.alert.accept
  end
end