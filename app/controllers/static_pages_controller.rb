class StaticPagesController < ApplicationController
  def home
    if logged_in?
      @micropost  = current_user.microposts.build
      @feed_items = current_user.feed.paginate(page: params[:page])
    end
  end



  def about
  end

  def contact
  end

  def donate
  end

  def howto
  end

  def coinbase
    @users = User.paginate(page: params[:page])
  end

  def nft
  end

  def admin
    @users = User.paginate(page: params[:page])
  end
end
private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :username, :email, :hobbies, :job_title, :job_company, :highest_education, :crypto_wallet_1, :crypto_wallet_2, :crypto_wallet_3, :facebook, :twitter, :github, :stackoverflow, :other_site, :cell, :marital_status, :sex, :interested_in, :password, :password_confirmation, :avatar, :banner)
  end
