class CommentsController < ApplicationController
    before_action :find_commentable, only: :create

    def new
      @comment = Comment.new
    end

    def create
        # binding.pry
      @commentable.comments.build(comment_params)
      if @commentable.save
        flash[:success] = "Comment created!"
        redirect_to root_path
      else
        render 'static_pages#home', status: :unprocessable_entity
      end
    end

    private

    def comment_params
      params.require(:comment).permit(:content)
    end

    def find_commentable
      if params[:comment_id]
        @commentable = Comment.find_by_id(params[:comment_id])
      elsif params[:micropost_id]
        @commentable = Micropost.find_by_id(params[:micropost_id])
      end
    end

end
