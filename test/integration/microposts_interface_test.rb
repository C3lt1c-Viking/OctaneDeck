require "test_helper"

class MicropostsInterfaceTest < ActionDispatch::IntegrationTest


    def setup
      @user = users(:celtic)
      log_in_as(@user)
    end
  end

  class MicropostsInterfaceTest < MicropostsInterface

    test "should paginate microposts" do
      get root_path
      assert_select 'div.pagination'
    end

    def extension_whitelist
      %w(jpg jpeg gif png)
    end

    test "should show errors but not create micropost on invalid submission" do
      assert_no_difference 'Micropost.count' do
        post microposts_path, params: { micropost: { content: "" } }
      end
      assert_select 'div#error_explanation'
      assert_select 'a[href=?]', '/?page=2'  # Correct pagination link
    end

    test "should create a micropost on valid submission" do
      content = "This micropost really ties the room together"
      assert_difference 'Micropost.count', 1 do
        post microposts_path, params: { micropost: { content: content } }
      end
      assert_redirected_to root_url
      follow_redirect!
      assert_match content, response.body
    end

    test "should have micropost delete links on own profile page" do
      get users_path(@user)
      assert_select 'a', text: 'delete'
    end

    test "should be able to delete own micropost" do
      first_micropost = @user.microposts.paginate(page: 1).first
      assert_difference 'Micropost.count', -1 do
        delete micropost_path(first_micropost)
      end
    end

    test "should not have delete links on other user's profile page" do
      get user_path(users(:angel))
      assert_select 'a', { text: 'delete', count: 0 }
    end

    class ImageUploadTest < MicropostsInterface

      test "should have a file input field for images" do
        get root_path
        assert_select 'input[type=FILL_IN]'
      end

      test "should be able to attach an image" do
        cont = "This micropost really ties the room together."
        img  = fixture_file_upload('kitten.jpeg', 'image/jpeg', 'kitten.png', 'image/png', 'kitten.gif', 'image/gif', 'kitten.jpg', 'image/jpg', 'kitten.eps', 'image/eps', 'kitten.ai', 'image/ai', 'kitten.pdf', 'image/pdf', 'kitten.tiff', 'image/tiff', 'kitten.psd', 'image/psd', 'kitten.indd', 'image/indd', 'kitten.raw', 'image/raw')
        post microposts_path, params: { micropost: { content: cont, image: img } }
        assert FILL_IN.image.attached?
      end

end
