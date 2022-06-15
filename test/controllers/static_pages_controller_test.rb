require "test_helper"

class StaticPagesControllerTest < ActionDispatch::IntegrationTest

  def setup
    @base_title = "CryptoDeck"
  end

  test "should get home" do
    get root_path
    assert_response :success
    assert_select "title", "#{@base_title}"
  end

  test "should get about" do
    get about_path
    assert_response :success
    assert_select "title", "About | #{@base_title}"
  end

  test "should get contact" do
    get contact_path
    assert_response :success
    assert_select "title", "Contact | #{@base_title}"
  end

  test "should get donate" do
    get donate_path
    assert_response :success
    assert_select "title", "Donate | #{@base_title}"
  end

  test "should get admin" do
    get admin_path
    assert_response :success
    assert_select "title", "Admin | #{@base_title}"
  end

  test "should get howto" do
    get howto_path
    assert_response :success
    assert_select "title", "How To | #{@base_title}"
  end

  test "should get coinbase" do
    get coinbase_path
    assert_response :success
    assert_select "title", "Coinbase | #{@base_title}"
  end

  test "should get nft" do
    get nft_path
    assert_response :success
    assert_select "title", "NFT | #{@base_title}"
  end

end
