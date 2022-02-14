require "application_system_test_case"

class PaymentsTest < ApplicationSystemTestCase

  test "Transaction is successful" do
    # Signing in the user
    Capybara.reset_sessions!
    visit new_user_session_path
    assert :success
    fill_in 'Email', with: 'foo@bar.com'
    fill_in 'Password', with: "password"
    click_button 'Log in'
    assert_selector "h1", text: "All Products"
    
    # Product is added and order details filled
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
    document = Nokogiri::XML(body)
    links = document.css('script')
    link = links.first
    approval_message = link.children[1].content["approved"]
    assert_equal "approved", approval_message
    @parsed_request = {"id"=>385132, "acquirer"=>"xml-sim", "order_number"=>"672886d80bbe4843b32d1644582021", "order_info"=>"Testna trx", "amount"=>1000, "currency"=>"EUR", "ch_full_name"=>"Test Test", "outgoing_amount"=>7524, "outgoing_currency"=>"HRK", "approval_code"=>"936436", "response_code"=>"0000", "response_message"=>"transaction approved", "reference_number"=>"809772", "systan"=>"385132", "eci"=>"06", "xid"=>nil, "acsv"=>nil, "cc_type"=>"visa", "status"=>"approved", "created_at"=>"2022-02-11T13:20:23.797+01:00", "transaction_type"=>"purchase", "enrollment"=>"N", "authentication"=>nil, "pan_token"=>nil, "ch_email"=>"tester+components_sdk@monri.com", "masked_pan"=>"411111-xxx-xxx-1111", "issuer"=>"xml-sim", "number_of_installments"=>nil, "custom_params"=>"195266743", "expiration_date"=>"3212"}
    assert_difference("Payment.count") do
      Payment.create(payment_result: @parsed_request)
    end
  end
end