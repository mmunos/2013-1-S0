class MoviesController < ApplicationController
  include UserReviewsPosts

  skip_before_filter :user_admin, only: [:show, :index, :add, :remove, :watch, :unwatch, :seen, :unseen, :show_reviews, :show_posts]
  skip_before_filter :authorize, only: [:show, :index, :show_reviews, :show_posts]
  before_action :set_movie, except: [:index, :create, :new]
  before_action :set_reviews, only:[:show, :show_reviews]
  before_action :set_posts, only:[:show, :show_posts]

  # GET /movies
  # GET /movies.json
  def index
    @movies = Movie.all
  end

  # GET /movies/1
  # GET /movies/1.json
  def show
  end

  # GET /movies/new
  def new
    @movie = Movie.new
  end

  # GET /movies/1/edit
  def edit
  end

  # POST /movies
  # POST /movies.json
  def create
    @movie = Movie.new(movie_params)

    respond_to do |format|
      if @movie.save
        format.html { redirect_to @movie, notice: 'Movie was successfully created.' }
        format.json { render action: 'show', status: :created, location: @movie }
      else
        format.html { render action: 'new' }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /movies/1
  # PATCH/PUT /movies/1.json
  def update
    respond_to do |format|
      if @movie.update(movie_params)
        format.html { redirect_to @movie, notice: 'Movie was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @movie.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /movies/1
  # DELETE /movies/1.json
  def destroy
    @movie.destroy
    respond_to do |format|
      format.html { redirect_to movies_url }
      format.json { head :no_content }
    end
  end

  def add
    if current_user
      if current_user.movies.include?(@movie)
        redirect_to @movie, notice: "You already follow this movie"
      else
        current_user.movies << @movie
        respond_to do |format|
          format.html { redirect_to @movie, notice: "#{@movie.name} was successfully added!" }
          format.js { render 'layouts/update_action_menu' }
        end
      end
    end
  end

  def remove
    if current_user
      if current_user.movies.include?(@movie)
        current_user.movies.delete(@movie)
        respond_to do |format|
          format.html { redirect_to @movie, notice: "#{@movie.name} was successfully removed!" }
          format.js { render 'layouts/update_action_menu' }
        end
      else
        redirect_to @movie, notice: "You can't delete #{@movie.name}, D'OH!!!"
      end
    end
  end

  def watch
    if current_user
      if current_user.watchlist.movies.include?(@movie)
        redirect_to @movie, notice: "You already added this movie to your watchlist"
      else
        current_user.watchlist.movies << @movie
        respond_to do |format|
          format.html { redirect_to @movie, notice: "#{@movie.name} was successfully added to watchlist!" }
          format.js { render 'layouts/update_action_menu' }
        end
      end
    end
  end

  def unwatch
    if current_user
      if current_user.watchlist.movies.include?(@movie)
        current_user.watchlist.movies.delete(@movie)
        respond_to do |format|
          format.html { redirect_to @movie, notice: "#{@movie.name} was successfully removed from watchlist!" }
          format.js { render 'layouts/update_action_menu' }
        end
      else
        redirect_to @movie, notice: "You can't delete #{@movie.name} from watchlist, D'OH!!!"
      end
    end
  end


  def seen
    if current_user
      if current_user.watched.movies.include?(@movie)
        redirect_to @movie, notice: "You already marked this movie as seen!"
      else
        current_user.watched.movies << @movie
        current_user.score_update(nil)
        respond_to do |format|
          format.html { redirect_to @movie, notice: "#{@movie.name} was successfully marked as seen!" }
          format.js { render 'layouts/update_action_menu' }
        end
      end
    end
  end

  def unseen
    if current_user
      if current_user.watched.movies.include?(@movie)
        current_user.watched.movies.delete(@movie)
        current_user.score_update(nil)
        respond_to do |format|
          format.html { redirect_to @movie, notice: "#{@movie.name} was successfully marked as unseen!" }
          format.js { render 'layouts/update_action_menu' }
        end
      else
        redirect_to @movie, notice: "You can't unseen #{@movie.name}, D'OH!!!"
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_movie
      @movie = Movie.find(params[:id])
    end

    def set_reviews
      @reviews = @movie.reviews
    end

    def set_posts
      @posts = @movie.posts
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def movie_params
      params.require(:movie).permit(:name, :date, :director, :genre, :duration, :description)
    end
end
