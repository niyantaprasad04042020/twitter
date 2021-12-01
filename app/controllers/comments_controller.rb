class CommentsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_comment, only: %i[ show edit update destroy ]

  # POST /comments or /comments.json
   def create
      @tweet   = Tweet.find(params[:tweet_id])
      @comment = @tweet.comments.create(comment_params)
      redirect_to tweet_path(@tweet)
    end

  # DELETE /comments/1 or /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to comments_url, notice: "Comment was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @comment = Comment.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:title, :description, :created_at, :updated_at, :user_id, :tweet_id)
    end
end
