class CommentsController < ApplicationController
  before_action :set_comment, only: [:show, :edit, :update, :destroy]

  # GET /comments
  # GET /comments.json
  def index
    @article = Article.find(params[:article_id])
    @comments = @article.comments.all
    respond_to do |format|
      format.json { render :json=>  {:status => 200, :response=>@comments }}
      format.html { @comments }
    end
  end

  # GET /comments/1
  # GET /comments/1.json
  def show
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    respond_to do |format|
      format.json {render :json=>  {:status => 200, :response=>@comment}}
      format.html {@comment}
      
    end
  end

  # GET /comments/new
  def new
    @article = Article.find(params[:article_id])
    @comment = Comment.new
  end

  # GET /comments/1/edit
  def edit
  end

  # POST /comments
  # POST /comments.json
  def create
    @article = Article.find(params[:article_id])
    @comment = @article.comments.create(comment_params)
    respond_to do |format|
      if @comment.save
        format.html { redirect_to article_comments_path(@article), notice: 'Comment was successfully'}
        format.json { render :json=>  {:status => 200, :response=>@comment }}
      else
        format.html { render :new }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /comments/1
  # PATCH/PUT /comments/1.json
  def update
    @article = Article.find(params[:article_id])
    @comment = @article.comments.update(comment_params)
    respond_to do |format|
      if @article.comments.update(comment_params)
        format.json { render :json=>  {:status => 200, :response=>@comment }}
        format.html { redirect_to article_comment_path(@article), notice: 'Comment was successfully updated.' }
        
      else
        format.html { render :edit }
        format.json { render json: @comment.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /comments/1
  # DELETE /comments/1.json
  def destroy
    @article = Article.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to article_comments_path(@article), notice: 'Comment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_comment
      @article = Article.find(params[:article_id])
      @comment = @article.comments.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def comment_params
      params.require(:comment).permit(:commenter, :body, :article_id)
    end
end
