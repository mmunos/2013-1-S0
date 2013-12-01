module Api 
  class MoviesController < ApiApplicationController

    before_filter :token_admin, only: [:create, :update, :destroy]
    before_filter :token_user, only: [:add, :remove, :watch, :unwatch, :seen, :unseen]

    before_action :set_movie, except: [:index, :create, :new]
    before_action :set_reviews, only:[:show, :reviews]
    before_action :set_posts, only:[:show, :posts]


    # GET /movies
    # GET /movies.json
    def index
      respond_with  Movie.all
    end

    # GET /movies/1
    # GET /movies/1.json
    def show
      respond_with @movie
    end

    # POST /movies
    # POST /movies.json
    def create
      @movie = Movie.create(movie_params)
      render json: {success: "true", message: "Movie has been created", movie: @movie}
    end

    # PATCH/PUT /movies/1
    # PATCH/PUT /movies/1.json
    def update
      @movie.update(movie_params)
      render json: {success: "true", message: "Movie has been updated", movie: @movie}
    end

    # DELETE /movies/1
    # DELETE /movies/1.json
    def destroy
      if @movie
        @movie.destroy
        render json: {success: "true", message: "Movie has been destroyed"}
      else
        render json: {success: "false", message: "Movie doesn't exist"}
      end
    end

    def add
      if token_user
        if token_user.movies.include?(@movie)
          render json: {success: "false", message: "User already has movie.", movie: @movie}
        else 
          token_user.movies << @movie
          render json: {success: "true", message: "Movie has been added.", movie: @movie}
        end
      end
    end

    def remove
      if token_user
        if token_user.movies.include?(@movie)
          token_user.movies.delete(@movie)
          render json: {success: "true", message: "Movie has been removed.", movie: @movie}
        else 
          render json: {success: "false", message: "User doesn't have the movie added.", movie: @movie}
        end
      end
    end

    def watch
      if token_user
        if token_user.watchlist.movies.include?(@movie)
          render json:{success: "false", message: "You already added this movie to your watchlist", movie: @movie}
        else
          token_user.watchlist.movies << @movie
          render json:{success: "true", message: "Movie was succcesfully added to user watchlist", movie: @movie}
        end
      end
    end

    def unwatch
      if token_user
        if token_user.watchlist.movies.include?(@movie)
          token_user.watchlist.movies.delete(@movie)
          render json:{success: "true", message: "Movie was succcesfully removed from user watchlist", movie: @movie}
        else
          render json:{success: "false", message: "Movie was not in user's watchlist", movie: @movie}
        end
      end
    end


    def seen
      if token_user
        if token_user.watched.movies.include?(@movie)
          render json: {success: "false", message: "User already marked this movie as seen!", movie: @movie }
        else
          token_user.watched.movies << @movie
          token_user.score_update(nil)
          render json: {success: "true", message: "User has marked this movie as seen.", movie: @movie }
        end
      end
    end

    def unseen
      if token_user
        if token_user.watched.movies.include?(@movie)
          token_user.watched.movies.delete(@movie)
          token_user.score_update(nil)
          render json: {success: "true", message: "User has marked this movie as unseen.", movie: @movie }
        else
          render json: {success: "true", message: "User has not seen this movie yet.", movie: @movie }
        end
      end
    end

    def reviews
      render json: {reviews: @movie.reviews, movie: @movie}
    end

    def posts
      render json: {posts: @movie.posts, movie: @movie}
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
        params.require(:movie).permit(:name, :date, :director, :genre, :duration, :description, :poster)
      end
  end
end