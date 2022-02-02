require "test_helper"

class PaymentsControllerTest < ActionDispatch::IntegrationTest

  def setup
    sign_in users(:foo)
  end

  test "can get to the new payment and get the JS form" do
    post orders_url params: {
        order: {
          currency: CURRENCY, address: "Address 2",
          city: "City 2", zip_code: 10000, phone: "003851111111", 
          transaction_type: "authorize"
        }
      }
    get new_payment_url
    assert_response :success
    assert_select "label", "Credit or debit card"
  end
end
