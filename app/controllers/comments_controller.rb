class CommentsController < ApplicationController
  before_action :set_comment, only: [:_comment, :edit, :update, :destroy]


  # POST /comments
  # POST /comments.json
  def create
    @post = Post.find(params[:post_id])
    @comment = @post.comments.new(comment_params)
    @comment.user = current_user

    respond_to do |format|
      if @comment.save
        format.html { redirect_to post_path@post, notice: 'Comment was successfully created.' }
        format.json { render :_comment, status: :created, location: @comment }
      else
        format.html { redirect_to post_path@post, alert: 'Error creating comment, try again in later.' }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end



  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to post_path@post, notice: 'Comment was successfully deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @post = Post.find(params[:post_id])
      @comment = @post.comments.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def comment_params
      params.require(:comment).permit(:content, :user_id, :post_id)
    end
end
