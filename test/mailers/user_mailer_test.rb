require "test_helper"

class UserMailerTest < ActionMailer::TestCase

  test "purchased" do
    user = users(:foo)
    email = UserMailer.purchased(user)

    assert_emails 1 do
      email.deliver_now
    end

    puts user.orders.last
    assert_equal [user.email], email.to
    assert_equal ['from@example.com'], email.from
  end
end
