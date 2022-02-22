require "test_helper"

class PaymentTest < ActiveSupport::TestCase

  #-------------------
  # Refund tests setup
  #-------------------

  def payment_result options = {}
    id = options.delete("id") || 386971
    order_number = options.delete("order_number") || "7a4a0106f156b54e44d81645108496"
    json_string = "{\"id\":386971,\"acquirer\":\"xml-sim\",\"order_number\":\"7a4a0106f156b54e44d81645108496\",\"order_info\":\"Testna trx\",\"amount\":242,\"currency\":\"EUR\",\"ch_full_name\":\"Test Test\",\"outgoing_amount\":1821,\"outgoing_currency\":\"HRK\",\"approval_code\":\"55624 \",\"response_code\":\"0000\",\"response_message\":\"transaction approved\",\"reference_number\":\"768068\",\"systan\":\"386971\",\"eci\":\"06\",\"xid\":null,\"acsv\":null,\"cc_type\":\"visa\",\"status\":\"approved\",\"created_at\":\"2022-02-17T15:35:07.256+01:00\",\"transaction_type\":\"purchase\",\"enrollment\":\"N\",\"authentication\":null,\"pan_token\":null,\"ch_email\":\"tester+components_sdk@monri.com\",\"masked_pan\":\"411111-xxx-xxx-1111\",\"issuer\":\"xml-sim\",\"number_of_installments\":null,\"custom_params\":\"#{Cart.last.id}\",\"expiration_date\":\"3212\"}"
    parsed_json = JSON.parse(json_string)
    parsed_json["id"] = id
    parsed_json["order_number"] = order_number
    JSON.generate(parsed_json)
  end
  
  def refund_function(payment_result)
    Payment.new(payment_result: payment_result).execute_refund
  end

  #------------
  # Refund tests
  #------------

  test "successful refund" do
    assert_equal 200, refund_function(payment_result).status
  end

  test "unsuccessful refund - no ID" do
    bad_id = payment_result("id" => "")
    assert_equal 404, refund_function(bad_id).status
  end

  test "unsuccessful refund - bad order_number" do
    bad_order_number = payment_result("order_number" => "BADBADBAD")
    assert_equal 422, refund_function(bad_order_number).status
    assert_equal "Invalid order_number", Nokogiri::XML(refund_function(bad_order_number).body).text.gsub("\n", "").strip
  end

  #-----------------------------
  # Validation of Payment Object
  #-----------------------------

  test "payment is valid" do
    @valid_payment = Payment.new(payment_result: payment_result)
    assert @valid_payment.valid?
  end

  test "payment is invalid" do
    bad_order_number = payment_result("order_number" => "BADBADBAD")
    @invalid_payment = Payment.new(payment_result: bad_order_number)
    refute @invalid_payment.valid?
  end
end
