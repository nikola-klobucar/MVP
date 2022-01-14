require "test_helper"

class UserTest < ActiveSupport::TestCase
  include ActionMailer::TestHelper

  test "can update password" do
    users(:foo).update(encrypted_password: "newpassword")
    assert_equal 'newpassword',users(:foo).encrypted_password
  end

  test "can update email" do
    users(:foo).update(email: "new@bar.com")
    assert_equal 'new@bar.com',users(:foo).email
  end

  test "send purchased mail" do
    user = users(:foo)
    assert_emails 1 do
      user.send_purchased_email
    end
  end
end
