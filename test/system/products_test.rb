require "application_system_test_case"

class ProductsTest < ApplicationSystemTestCase


  test "Product can be editted" do
    @admin = AdminUser.new(email:"admin@admin.com", password: "password", password_confirmation: "password")
    @admin.save!
    @product = Product.last
    assert_equal false, @product.sold?
    visit new_admin_user_session_path
    fill_in 'Email', with: 'admin@admin.com'
    fill_in 'Password', with: "password"
    click_button "Login"
    click_link "Products"
    first(:link, "Edit").click
    page.execute_script "window.scrollBy(0,10000)"
    check "Sold"
    click_button "Update Product"
    @product = Product.last
    assert_selector "h2", text: @product.name
    assert_equal true, @product.sold?
  end

  test "Product can be deleted" do
    @admin = AdminUser.new(email:"admin@admin.com", password: "password", password_confirmation: "password")
    @admin.save!

    visit new_admin_user_session_path
    fill_in 'Email', with: 'admin@admin.com'
    fill_in 'Password', with: "password"
    # assert_response :success
    click_button "Login"
    click_link "Products"
    first(:link, "Delete").click
    page.driver.browser.switch_to.alert.accept
  end

end
