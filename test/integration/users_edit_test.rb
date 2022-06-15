require "test_helper"

class UsersEditTest < ActionDispatch::IntegrationTest

  def setup
    @user = users(:celtic)
  end

  test "unsuccessful edit" do
    log_in_as(@user)
    get edit_user_path(@user)
    assert_template 'users/edit'
    patch user_path(@user), params: { user: { first_name:  "",
                                              last_name: "",
                                              username: "",
                                              email: "foo@invalid",
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

    assert_template 'users/edit'
  end

  test "successful edit with friendly forwarding" do
    get edit_user_path(@user)
    log_in_as(@user)
    assert_redirected_to edit_user_url(@user)
    first_name        = "Celtic"
    last_name         = "Viking"
    username          = "C3lt1cViking"
    email             = "c3lt1cviking@tuta.io"
    hobbies           = "Hacking | Coding | Family Time!"
    job_title         = "Ruby on Rails Engineer"
    job_company       = "C3lt1c Viking Operations"
    highest_education = "Doctoral of Computer Science"
    crypto_wallet_1   = "abc123"
    crypto_wallet_2   = "abc321"
    crypto_wallet_3   = "a1c2b3"
    facebook          = "https://www.facebook.com/"
    twitter           = "https://www.twitter.com/C3lt1cViking"
    github            = "https://www.github.com/C3lt1c-Viking"
    stackoverflow     = "https://stackoverflow.com/users/19276054/c3lt1cviking"
    other_site        = "https://www.c3lt1cviking.com"
    cell              = "888-555-0508"
    marital_status    = "Married"
    interested_in     = "Friends"
    patch user_path(@user), params: { user: { first_name:  first_name,
                                              last_name: last_name,
                                              username: username,
                                              email: email,
                                              hobbies: hobbies,
                                              job_title: job_title,
                                              job_company: job_company,
                                              highest_education: highest_education,
                                              crypto_wallet_1: crypto_wallet_1,
                                              crypto_wallet_2: crypto_wallet_2,
                                              crypto_wallet_3: crypto_wallet_3,
                                              facebook: facebook,
                                              twitter: twitter,
                                              github: github,
                                              stackoverflow: stackoverflow,
                                              other_site: other_site,
                                              cell: cell,
                                              marital_status: marital_status,
                                              interested_in: interested_in,
                                              password:              "",
                                              password_confirmation: "" } }
    assert_not flash.empty?
    assert_redirected_to @user
    @user.reload
    assert_equal first_name, @user.first_name
    assert_equal last_name, @user.last_name
    assert_equal username, @user.username
    assert_equal email, @user.email
    assert_equal hobbies, @user.hobbies
    assert_equal job_title, @user.job_title
    assert_equal job_company, @user.job_company
    assert_equal highest_education, @user.highest_education
    assert_equal crypto_wallet_1, @user.crypto_wallet_1
    assert_equal crypto_wallet_2, @user.crypto_wallet_2
    assert_equal crypto_wallet_3, @user.crypto_wallet_3
    assert_equal facebook, @user.facebook
    assert_equal twitter, @user.twitter
    assert_equal github, @user.github
    assert_equal stackoverflow, @user.stackoverflow
    assert_equal other_site, @user.other_site
    assert_equal cell, @user.cell
    assert_equal marital_status, @user.marital_status
    assert_equal interested_in, @user.interested_in
  end

end
