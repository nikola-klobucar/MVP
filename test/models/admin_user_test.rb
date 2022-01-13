require "test_helper"

class AdminUserTest < ActiveSupport::TestCase
  test "the admin is valid" do
    assert admin_users(:admin)
  end
end
