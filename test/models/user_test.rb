require "test_helper"

class UserTest < ActiveSupport::TestCase

  def setup
    @user = User.new(first_name: "C3lt1c", last_name: "Viking", username: "C3lt1c Viking", email: "c3lt1cviking@tuta.io", hobbies: "Ethical Hacking & programming! Spending time with my wife & kids!", job_title: "Lead RoR Developer", job_company: "C3lt1c Viking Operations | CryptoDeck", highest_education: "Doctor of Computer Science", crypto_wallet_1: "34S7RQAX9kGqdGdpaym7hmdC4C2aouv8gz", crypto_wallet_2: "DCAhwJiqgjsXMRgRTpwzAQW4QdWd3VGpib", crypto_wallet_3: "0xf914c7bfA916177A433e6D7d2DA3722C29b403Ce", facebook: "https://www.facebook.com/profile.php?id=100075628515202", twitter: "https://twitter.com/C3lt1cViking", github: "https://github.com/C3lt1c-Viking", stackoverflow: "https://stackoverflow.com/users/19276054/c3lt1cviking", cell: "888-555-0505", marital_status: "Married", sex: "Robot", interested_in: "Making Friends", password: "abc123", password_confirmation: "abc123")
  end

  test "should be valid" do
    assert @user.valid?
  end

  test "first_name should be present" do
    @user.first_name = "    "
    assert_not @user.valid?
  end

  test "first_name should not be too long" do
    @user.first_name = "a" * 51
    assert_not @user.valid?
  end

  test "last_name should be present" do
    @user.last_name = "    "
    assert_not @user.valid?
  end

  test "last_name should not be too long" do
    @user.last_name = "a" * 51
    assert_not @user.valid?
  end

  test "username should be present" do
    @user.username = "    "
    assert_not @user.valid?
  end

  test "username should not be too long" do
    @user.username = "a" * 51
    assert_not @user.valid?
  end

  test "email should be present" do
    @user.email = "    "
    assert_not @user.valid?
  end

  test "email should not be too long" do
    @user.email = "a" * 244 + "@example.com"
    assert_not @user.valid?
  end

  test "email validation should accept valid addresses" do
    valid_addresses = %w[user@example.com USER@example.COM A_US-ER@c3lt1c.viking.org
                         first.last@c3lt1c.jp alice+bob@join.cn]
    valid_addresses.each do |valid_address|
      @user.email = valid_address
      assert @user.valid?, "#{valid_address.inspect} should be valid"
    end
  end

  test "email validation should reject invalid addresses" do
    invalid_addresses = %w[user@example,com user_at_example.org user.name@example.
                           foo@bar_baz.com foo@bar+baz.com]
    invalid_addresses.each do |invalid_address|
      @user.email = invalid_address
      assert_not @user.valid?, "#{invalid_address.inspect} should be invalid"
    end
  end

  test "email addresses should be unique" do
    duplicate_user = @user.dup
    @user.save
    assert_not duplicate_user.valid?
  end

  test "email addresses should be saved as lowercase" do
    mixed_case_email = "Foo@ExAMPle.CoM"
    @user.email = mixed_case_email
    @user.save
    assert_equal mixed_case_email.downcase, @user.reload.email
  end


  test "hobbies should be present" do
    @user.hobbies = "    "
    assert_not @user.valid?
  end

  test "hobbies should not be too long" do
    @user.hobbies = "a" * 1001
    assert_not @user.valid?
  end

  test "job_title should be present" do
    @user.job_title = "    "
    assert_not @user.valid?
  end

  test "job_title should not be too long" do
    @user.job_title = "a" * 66
    assert_not @user.valid?
  end

  test "job_company should be present" do
    @user.job_company = "    "
    assert_not @user.valid?
  end

  test "job_company should not be too long" do
    @user.job_company = "a" * 66
    assert_not @user.valid?
  end

  test "highest_education should be present" do
    @user.highest_education = "    "
    assert_not @user.valid?
  end

  test "highest_education should not be too long" do
    @user.highest_education = "a" * 101
    assert_not @user.valid?
  end

  test "crypto_wallet_1 should be present" do
    @user.crypto_wallet_1 = "    "
    assert_not @user.valid?
  end

  test "crypto_wallet_1 should not be too long" do
    @user.crypto_wallet_1 = "a" * 101
    assert_not @user.valid?
  end

  test "crypto_wallet_2 should be present" do
    @user.crypto_wallet_2 = "    "
    assert_not @user.valid?
  end

  test "crypto_wallet_2 should not be too long" do
    @user.crypto_wallet_2 = "a" * 101
    assert_not @user.valid?
  end

  test "crypto_wallet_3 should be present" do
    @user.crypto_wallet_3 = "    "
    assert_not @user.valid?
  end

  test "crypto_wallet_3 should not be too long" do
    @user.crypto_wallet_3 = "a" * 101
    assert_not @user.valid?
  end

  test "facebook should be present" do
    @user.facebook = "    "
    assert_not @user.valid?
  end

  test "facebook should not be too long" do
    @user.facebook = "a" * 71
    assert_not @user.valid?
  end

  test "twitter should be present" do
    @user.twitter = "    "
    assert_not @user.valid?
  end

  test "twitter should not be too long" do
    @user.twitter = "a" * 71
    assert_not @user.valid?
  end

  test "github should be present" do
    @user.github = "    "
    assert_not @user.valid?
  end

  test "github should not be too long" do
    @user.github = "a" * 71
    assert_not @user.valid?
  end

  test "stackoverflow should be present" do
    @user.stackoverflow = "    "
    assert_not @user.valid?
  end

  test "stackoverflow should not be too long" do
    @user.stackoverflow = "a" * 71
    assert_not @user.valid?
  end

  test "othersite should be present" do
    @user.other_site = "    "
    assert_not @user.valid?
  end

  test "othersite should not be too long" do
    @user.other_site = "a" * 71
    assert_not @user.valid?
  end

  test "cell should be present" do
    @user.cell = "    "
    assert_not @user.valid?
  end

  test "cell should not be too long" do
    @user.cell = "a" * 21
    assert_not @user.valid?
  end

  test "marital_status should be present" do
    @user.marital_status = "    "
    assert_not @user.valid?
  end

  test "marital_status should not be too long" do
    @user.marital_status = "a" * 31
    assert_not @user.valid?
  end

  test "sex should be present" do
    @user.sex = "    "
    assert_not @user.valid?
  end

  test "sex should not be too long" do
    @user.sex = "a" * 21
    assert_not @user.valid?
  end

  test "interested_in should be present" do
    @user.interested_in = "    "
    assert_not @user.valid?
  end

  test "interested_in should not be too long" do
    @user.interested_in = "a" * 101
    assert_not @user.valid?
  end

  test "password should be present (nonblank)" do
    @user.password = @user.password_confirmation = " " * 6
    assert_not @user.valid?
  end

  test "password should have a minimum length" do
    @user.password = @user.password_confirmation = "a" * 5
    assert_not @user.valid?
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?('')
  end

  test "associated microposts should be destroyed" do
    @user.save
    @user.microposts.create!(content: "Lorem ipsum")
    assert_difference 'Micropost.count', -1 do
      @user.destroy
    end
  end

  test "should follow and unfollow a user" do
    celtic = users(:celtic)
    angel  = users(:angel)
    assert_not celtic.following?(angel)
    celtic.follow(angel)
    assert celtic.following?(angel)
    assert angel.followers.include?(celtic)
    celtic.unfollow(angel)
    assert_not celtic.following?(angel)
    # Users can't follow themselves.
    celtic.follow(celtic)
    assert_not celtic.following?(celtic)
  end

  test "feed should have the right posts" do
    celtic = users(:celtic)
    angel  = users(:angel)
    viking    = users(:viking)
    # Posts from followed user
    viking.microposts.each do |post_following|
      assert celtic.feed.include?(post_following)
    end
    # Self-posts for user with followers
    celtic.microposts.each do |post_self|
      assert celtic.feed.include?(post_self)
    end
    # Posts from non-followed user
    angel.microposts.each do |post_unfollowed|
      assert_not celtic.feed.include?(post_unfollowed)
    end
  end

  test "authenticated? should return false for a user with nil digest" do
    assert_not @user.authenticated?(:remember, '')
  end

end
