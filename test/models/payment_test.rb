require "test_helper"

class PaymentTest < ActiveSupport::TestCase

  #-------------------
  # Refund tests setup
  #-------------------

  def payment_result(*key_value)
    @hash = {"id"=>385132, "acquirer"=>"xml-sim", "order_number"=>"672886d80bbe4843b32d1644582021", "order_info"=>"Testna trx", "amount"=>1000, "currency"=>"EUR", "ch_full_name"=>"Test Test", "outgoing_amount"=>7524, "outgoing_currency"=>"HRK", "approval_code"=>"936436", "response_code"=>"0000", "response_message"=>"transaction approved", "reference_number"=>"809772", "systan"=>"385132", "eci"=>"06", "xid"=>nil, "acsv"=>nil, "cc_type"=>"visa", "status"=>"approved", "created_at"=>"2022-02-11T13:20:23.797+01:00", "transaction_type"=>"purchase", "enrollment"=>"N", "authentication"=>nil, "pan_token"=>nil, "ch_email"=>"tester+components_sdk@monri.com", "masked_pan"=>"411111-xxx-xxx-1111", "issuer"=>"xml-sim", "number_of_installments"=>nil, "custom_params"=>"195266743", "expiration_date"=>"3212"}
    @hash[key_value[0]] = key_value[1]
    @hash
  end
  
  def refund_function(payment_result)
    Payment.new(payment_result: payment_result).refund_functionality
  end

  #------------
  # Refund tests
  #------------

  test "successful refund" do
    assert_equal 200, refund_function(payment_result).status
  end

  test "unsuccessful refund - no ID" do
    bad_id = payment_result("id", "")
    assert_equal 404, refund_function(bad_id).status
  end

  test "unsuccessful refund - bad order_number" do
    bad_order_number = payment_result("order_number", "BADBADBAD")
    assert_equal 422, refund_function(bad_order_number).status
    assert_equal "Invalid order_number", Nokogiri::XML(refund_function(bad_order_number).body).text.gsub("\n", "").strip
  end
end
