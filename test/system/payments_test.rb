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
    sleep(1)
    document = Nokogiri::XML(body)
    links = document.css('script')
    link = links.first
    approval_message = link.children[1].content["approved"]
    assert_equal "approved", approval_message
    @raw_request = "{\"id\":386971,\"acquirer\":\"xml-sim\",\"order_number\":\"#{Order.last.order_number}\",\"order_info\":\"Testna trx\",\"amount\":242,\"currency\":\"EUR\",\"ch_full_name\":\"Test Test\",\"outgoing_amount\":1821,\"outgoing_currency\":\"HRK\",\"approval_code\":\"55624 \",\"response_code\":\"0000\",\"response_message\":\"transaction approved\",\"reference_number\":\"768068\",\"systan\":\"386971\",\"eci\":\"06\",\"xid\":null,\"acsv\":null,\"cc_type\":\"visa\",\"status\":\"approved\",\"created_at\":\"2022-02-17T15:35:07.256+01:00\",\"transaction_type\":\"purchase\",\"enrollment\":\"N\",\"authentication\":null,\"pan_token\":null,\"ch_email\":\"tester+components_sdk@monri.com\",\"masked_pan\":\"411111-xxx-xxx-1111\",\"issuer\":\"xml-sim\",\"number_of_installments\":null,\"custom_params\":\"#{Cart.last.id}\",\"expiration_date\":\"3212\"}"
    assert_difference("Payment.count") do
      Payment.create(payment_result: @raw_request, order: Order.last)
    end
  end

  test "Refund is successfull and shows refund_reference and its response message" do
    test_Transaction_is_successful

    # Signing in the Admin User
    Capybara.reset_sessions!
    visit new_admin_user_session_path
    assert :success
    fill_in 'Email', with: 'admin@example.com'
    fill_in 'Password', with: "password"
    click_button 'Login'
    assert_selector "h2", text: "Dashboard"

    #Go to Edit Payment
    click_link "Payments"
    assert_selector "h2", text: "Payments"
    click_link "View"
    page.assert_selector('th', text: 'REFUND')
    page.assert_selector('td', text: 'NO')
    click_link "Refund"
    
    # Refund
    page.assert_selector('th', text: 'REFUND')
    page.assert_selector('td', text: 'YES')
    assert_equal "Payment has been successfully refunded", Nokogiri::XML(body).css('div.flash').text

    # There is no more Refund link
    assert has_no_field?('Refund')

    # Asserting refund reference
    first(:link, "Payments").click
    page.assert_selector('td', text: "Refund reference ##{Payment.last.id}")
    click_link "Refund reference ##{Payment.last.id}"
    page.assert_selector('th', text: "RESPONSE")
  end
end