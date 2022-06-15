require "test_helper"

class UsersSignupTest < ActionDispatch::IntegrationTest

  def setup
    ActionMailer::Base.deliveries.clear
  end
end


class UsersSignupTest < UsersSignup
  test "invalid signup information" do
    get signup_path
    assert_no_difference 'User.count' do
      post users_path, params: { user: { first_name:  "",
                                         last_name: "",
                                         username: "",
                                         email: "user@invalid",
                                         hobbies: "",
                                         job_title: "",
                                         job_company: "",
                                         highest_education: "",
                                         crypto_wallet_1: "",
                                         crypto_wallet_2: "",
                                         crypto_wallet_3: "",
                                         facebook: "",
                                         twitter: "",
                                         github: "",
                                         stackoverflow: "",
                                         other_site: "",
                                         cell: "",
                                         marital_status: "",
                                         sex: "",
                                         interested_in: "",
                                         password:              "foo",
                                         password_confirmation: "bar" } }
    end
    assert_response :unprocessable_entity
    assert_template 'users/new'
    end

  test "valid signup information with account activation" do
    assert_difference 'User.count', 1 do
      post users_path, params: { user: { first_name:  "C3lt1c",
                                         last_name: "Viking",
                                         username: "C3lt1cViking",
                                         email: "user@example.com",
                                         hobbies: "Coding | Hacking | Family Time",
                                         job_title: "Ruby on Rails Engineer",
                                         job_company: "C3lt1c Viking Operations",
                                         highest_education: "Doctoral of Computer Science",
                                         crypto_wallet_1: "abc123",
                                         crypto_wallet_2: "abc321",
                                         crypto_wallet_3: "321cba",
                                         facebook: "https://www.facebook.com/C3lt1cViking",
                                         twitter: "https://www.twitter.com/C3lt1cViking",
                                         github: "https://www.github.com/C3lt1c-Viking",
                                         stackoverflow: "https://stackoverflow.com/users/19276054/c3lt1cviking",
                                         other_site: "https://www.c3lt1cviking.com",
                                         cell: "888-555-0505",
                                         marital_status: "Married",
                                         sex: "Robot",
                                         interested_in: "Friends",
                                         password:              "password",
                                         password_confirmation: "password" } }
    end
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
    assert_equal 1, ActionMailer::Base.deliveries.size
  end
end

class AccountActivationTest < UsersSignup

  def setup
    super
    post users_path, params: { user: { first_name:  "C3lt1c",
                                       last_name: "Viking",
                                       username: "C3lt1cViking",
                                       email: "user@example.com",
                                       hobbies: "Coding | Hacking | Family Time",
                                       job_title: "Ruby on Rails Engineer",
                                       job_company: "C3lt1c Viking Operations",
                                       highest_education: "Doctoral of Computer Science",
                                       crypto_wallet_1: "abc123",
                                       crypto_wallet_2: "abc321",
                                       crypto_wallet_3: "321cba",
                                       facebook: "https://www.facebook.com/C3lt1cViking",
                                       twitter: "https://www.twitter.com/C3lt1cViking",
                                       github: "https://www.github.com/C3lt1c-Viking",
                                       stackoverflow: "https://stackoverflow.com/users/19276054/c3lt1cviking",
                                       other_site: "https://www.c3lt1cviking.com",
                                       cell: "888-555-0505",
                                       marital_status: "Married",
                                       sex: "Robot",
                                       interested_in: "Friends",
                                       password:              "password",
                                       password_confirmation: "password"} }
    @user = assigns(:user)
  end

  test "should not be activated" do
    assert_not @user.activated?
  end

  test "should not be able to log in before account activation" do
    log_in_as(@user)
    assert_not is_logged_in?
  end

  test "should not be able to log in with invalid activation token" do
    get edit_account_activation_path("invalid token", email: @user.email)
    assert_not is_logged_in?
  end

  test "should not be able to log in with invalid email" do
    get edit_account_activation_path(@user.activation_token, email: 'wrong')
    assert_not is_logged_in?
  end

  test "should log in successfully with valid activation token and email" do
    get edit_account_activation_path(@user.activation_token, email: @user.email)
    assert @user.reload.activated?
    follow_redirect!
    assert_template 'users/show'
    assert is_logged_in?
  end
end
