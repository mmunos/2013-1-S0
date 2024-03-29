class ReviewsController < ApplicationController
  skip_before_filter :user_admin, only: [:show, :index, :add, :destroy, :create]
  skip_before_filter :authorize, only: [:index, :show]
  before_action :set_review, only: [:show, :edit, :update, :destroy]

  # GET /reviews
  # GET /reviews.json

  # def index
  #   @reviews = @parent.reviews
  #   respond_to do |format|
  #     format.html { redirect_to polymorphic_path(@array_parent) }
  #     format.js
  #   end
  # end

  # GET /reviews/1
  # GET /reviews/1.json
  def show
  end

  # GET /reviews/new
  def new
    @review = Review.new
    redirect_to polymorphic_path(@array_parent)
  end

  # GET /reviews/1/edit
  def edit
  end

  # POST /reviews
  # POST /reviews.json
  def create
    @review = Review.new(review_params)
    @parent.reviews << @review
    
    respond_to do |format|
      if @review.save
        u=User.find_by_id(@review.user_id)
        u.score_update(@parent)
        format.html { redirect_to polymorphic_path(@array_parent), notice: 'Review was successfully created.' }
        format.js 
        format.json { render action: 'show', status: :created, location: @review }
      else
        format.html { redirect_to polymorphic_path(@array_parent), alert: @review.errors.full_messages.first}
        format.js { render action: 'error', object: @review.errors }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /reviews/1
  # PATCH/PUT /reviews/1.json
  def update
    respond_to do |format|
      if @review.update(review_params)
        format.html { redirect_to polymorphic_path(@array_parent), notice: 'Review was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @review.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /reviews/1
  # DELETE /reviews/1.json
  def destroy
    @review.destroy
    u=User.find_by_id(@review.user_id)
    u.score_update(@parent)
    respond_to do |format|
      format.html { redirect_to polymorphic_path(@array_parent), notice: 'Your review was deleted.' }
      format.js 
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_review
      @review = Review.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def review_params
      params.require(:review).permit(:user_id, :rating, :content, :reviewable_id)
    end
end
