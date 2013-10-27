class WatchedController < ApplicationController
  before_action :set_watched, only: [:show, :edit, :update, :destroy]



  def index
    @watchlists = Watchlist.all
  end

  def my_watched
    if current_user
      @watchlist = current_user.watchlist
      render action: 'show'
    end
  end


  # GET /watchlists/1
  # GET /watchlists/1.json
  def show
  end


  # GET /watchlists/new
  def new
    @watchlist = Watchlist.new
  end

  # GET /watchlists/1/edit
  def edit
  end



  def create
    @watched = Watchlist.new(watched_params)
    respond_to do |format|
      if @watched.save
        format.html { redirect_to @watched, notice: 'watchedlist was successfully created.' }
        format.json { render action: 'show', status: :created, location: @watched }
      else
        format.html { render action: 'new' }
        format.json { render json: @watched.errors, status: :unprocessable_entity }
      end
    end
  end



  def destroy
    @watched.destroy
    respond_to do |format|
      format.html { redirect_to watched_url }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_watched
      user = User.find(params[:user_id])
      if user 
        @watched = Watched.find_by(user_id: user.id)
      else 
        @watched = Watched.find(params[:id])
      end

    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def watched_params
      params.require(:watched).permit(:user_id)
    end

end
