require "test_helper"

class UsersControllerTest < ActionDispatch::IntegrationTest
  before_action :logged_in_user, only: [:edit, :update]

  def setup
    @user       = users(:celtic)
    @other_user = users(:angel)
  end


  test "should get new" do
    get signup_path
    assert_response :success
  end

  test "should redirect index when not logged in" do
    get users_path
    assert_redirected_to login_url
  end

  test "should redirect edit when not logged in" do
    get edit_user_path(@user)
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect update when not logged in" do
    patch user_path(@user), params: { user: { first_name: @user.first_name,
                                              last_name: @user.last_name,
                                              username: @user.username,
                                              email: @user.email,
                                              hobbies: @user.hobbies,
                                              job_title: @user.job_title,
                                              job_company: @user.job_company,
                                              highest_education: @user.highest_education,
                                              crypto_wallet_1: @user.crypto_wallet_1,
                                              crypto_wallet_2: @user.crypto_wallet_2,
                                              crypto_wallet_3: @user.crypto_wallet_3,
                                              facebook: @user.facebook,
                                              twitter: @user.twitter,
                                              github: @user.github,
                                              stackoverflow: @user.stackoverflow,
                                              other_site: @user.other_site,
                                              cell: @user.cell,
                                              marital_status: @user.marital_status,
                                              sex: @user.sex,
                                              interested_in: @user.interested_in } }
    assert_not flash.empty?
    assert_redirected_to login_url
  end

  test "should redirect edit when logged in as wrong user" do
    log_in_as(@other_user)
    get edit_user_path(@user)
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect update when logged in as wrong user" do
    log_in_as(@other_user)
    patch user_path(@user), params: { user: { first_name: @user.first_name,
                                              last_name: @user.last_name,
                                              username: @user.username,
                                              email: @user.email,
                                              hobbies: @user.hobbies,
                                              job_title: @user.job_title,
                                              job_company: @user.job_company,
                                              highest_education: @user.highest_education,
                                              crypto_wallet_1: @user.crypto_wallet_1,
                                              crypto_wallet_2: @user.crypto_wallet_2,
                                              crypto_wallet_3: @user.crypto_wallet_3,
                                              facebook: @user.facebook,
                                              twitter: @user.twitter,
                                              github: @user.github,
                                              stackoverflow: @user.stackoverflow,
                                              other_site: @user.other_site,
                                              cell: @user.cell,
                                              marital_status: @user.marital_status,
                                              sex: @user.sex,
                                              interested_in: @user.interested_in } }
    assert flash.empty?
    assert_redirected_to root_url
  end

  test "should redirect destroy when not logged in" do
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_response :see_other
    assert_redirected_to login_url
  end

  test "should redirect destroy when logged in as a non-admin" do
    log_in_as(@other_user)
    assert_no_difference 'User.count' do
      delete user_path(@user)
    end
    assert_response :see_other
    assert_redirected_to root_url
  end

  test "should redirect following when not logged in" do
    get following_user_path(@user)
    assert_redirected_to login_url
  end

  test "should redirect followers when not logged in" do
    get followers_user_path(@user)
    assert_redirected_to login_url
  end

end
