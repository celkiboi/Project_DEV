class CommentsController < ApplicationController
    before_action :authenticate_user!
  
    def create
      @post = Post.find(params[:post_id])
      @comment = @post.comments.build(comment_params)
      @comment.user = current_user
  
      if @comment.save
        render partial: 'comments/comment_list', locals: { comments: @post.comments }
      else
        render plain: "Error creating comment", status: :unprocessable_entity
      end
    end
  
    def destroy
      @comment = current_user.comments.find(params[:id])
      @post = @comment.post
      @comment.destroy
  
      render partial: 'comments/comment_list', locals: { comments: @post.comments }
    end
  
    private
  
    def comment_params
      params.require(:comment).permit(:content)
    end
  end
  