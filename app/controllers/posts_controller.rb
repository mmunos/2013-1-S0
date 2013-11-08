class PostsController < ApplicationController
  include ApplicationHelper

  skip_before_filter :user_admin, only: [:show, :index, :add, :destroy, :create]
  skip_before_filter :authorize, only: [:index, :show]
  before_action :set_parent
  before_action :set_redirect_parent
  before_action :set_post, only: [:show, :edit, :update, :destroy]

  # GET /posts
  # GET /posts.json
  def index
    @posts = @parent.posts
  end

  # GET /posts/1
  # GET /posts/1.json
  def show
  end

  # GET /posts/new
  def new
    @post = Post.new
  end

  # GET /posts/1/edit
  def edit
  end

  # POST /posts
  # POST /posts.json
  def create
    @post = Post.new(post_params)
    @post.user = current_user
    @parent.posts << @post

    respond_to do |format|
      if @post.save
        format.html { redirect_to polymorphic_path(@redirect_parent), notice: 'Post was successfully created.' }
        format.json { render action: 'show', status: :created, location: @post }
      else
        format.html { redirect_to polymorphic_path(@redirect_parent), alert: @post.errors.full_messages.first }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1
  # PATCH/PUT /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        format.html { redirect_to polymorphic_path(@redirect_parent), notice: 'Post was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1
  # DELETE /posts/1.json
  def destroy
    @post.destroy
    respond_to do |format|
      format.html { redirect_to polymorphic_path(@redirect_parent), notice: 'Your post was deleted.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    def set_parent
      @parent = find_parent_models()[-2]
    end

    def set_redirect_parent
      @redirect_parent = find_parent_models()
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_params
       params.require(:post).permit(:user_id, :content, :commentable_id)
    end
end
