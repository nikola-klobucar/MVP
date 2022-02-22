require "test_helper"

class AdminPaymentsControllerTest < ActionDispatch::IntegrationTest

  def setup
    sign_in admin_users(:admin)
  end

  test "refund is successfull" do
    @cart = Cart.new(order: orders(:order_one), user: users(:foo))
    @cart.save
    @raw_request = "{\"id\":386971,\"acquirer\":\"xml-sim\",\"order_number\":\"7a4a0106f156b54e44d81645108496\",\"order_info\":\"Testna trx\",\"amount\":242,\"currency\":\"EUR\",\"ch_full_name\":\"Test Test\",\"outgoing_amount\":1821,\"outgoing_currency\":\"HRK\",\"approval_code\":\"55624 \",\"response_code\":\"0000\",\"response_message\":\"transaction approved\",\"reference_number\":\"768068\",\"systan\":\"386971\",\"eci\":\"06\",\"xid\":null,\"acsv\":null,\"cc_type\":\"visa\",\"status\":\"approved\",\"created_at\":\"2022-02-17T15:35:07.256+01:00\",\"transaction_type\":\"purchase\",\"enrollment\":\"N\",\"authentication\":null,\"pan_token\":null,\"ch_email\":\"tester+components_sdk@monri.com\",\"masked_pan\":\"411111-xxx-xxx-1111\",\"issuer\":\"xml-sim\",\"number_of_installments\":null,\"custom_params\":\"#{@cart.id}\",\"expiration_date\":\"3212\"}"
    @payment = Payment.new(payment_result: @raw_request, order: orders(:order_one))
    @payment.save
    patch admin_payment_path(Payment.last),  params: {
      payment: {
        refund: true
      }
    }
    assert_equal true, Payment.last.refund
    assert_equal "Payment was successfully updated", flash[:notice]
  end

  test "refund is not successfull" do
    @cart = Cart.new(order: orders(:order_one), user: users(:foo))
    @cart.save
    @raw_request = "{\"id\":386971,\"acquirer\":\"xml-sim\",\"order_number\":\"7a4a0106f156b54e44d81645108496\",\"order_info\":\"Testna trx\",\"amount\":242,\"currency\":\"EUR\",\"ch_full_name\":\"Test Test\",\"outgoing_amount\":1821,\"outgoing_currency\":\"HRK\",\"approval_code\":\"55624 \",\"response_code\":\"0000\",\"response_message\":\"transaction approved\",\"reference_number\":\"768068\",\"systan\":\"386971\",\"eci\":\"06\",\"xid\":null,\"acsv\":null,\"cc_type\":\"visa\",\"status\":\"approved\",\"created_at\":\"2022-02-17T15:35:07.256+01:00\",\"transaction_type\":\"purchase\",\"enrollment\":\"N\",\"authentication\":null,\"pan_token\":null,\"ch_email\":\"tester+components_sdk@monri.com\",\"masked_pan\":\"411111-xxx-xxx-1111\",\"issuer\":\"xml-sim\",\"number_of_installments\":null,\"custom_params\":\"#{@cart.id}\",\"expiration_date\":\"3212\"}"
    @payment = Payment.new(payment_result: @raw_request, order: orders(:order_one), refund: true)
    @payment.save
    patch admin_payment_path(Payment.last),  params: {
      payment: {
        refund: false
      }
    }
    assert_not_equal true, Payment.last.refund
    assert_equal "Refund has been unsuccessful", flash.now[:notice]
  end
end