class WatchedController < ApplicationController
  skip_before_filter :user_admin, only: [:show, :index, :my_watched]
  before_action :set_watched, only: [:show, :edit, :update, :destroy, :my_watched]
  before_action :set_seasons, only: [:my_watched]
  before_action :set_series, only: [:my_watched]



  def index
    @watchlists = Watchlist.all
  end

  def my_watched
    if current_user
      @watched = current_user.watched
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
        @watched = current_user.watched
      else 
        @watched = current_user.watched
      end

    end

    #full seasons
    def set_seasons
    	@seasons = []
    	actual_id = 0
    	previous_id= 0
    	actual_e_season=0
    	e_numero=0
   	 	@watched.episodes.sort {|a,b| a.season_id <=> b.season_id}.each do |e|
   	 		actual_id = e.season_id
   	 		@seasons << Season.find_by_id(e.season_id)
   	 		if(actual_id!=previous_id and actual_id!=0)
   	 			previous_id = actual_id
   	 			if Season.find_by_id(e.season_id).episodes.size <= e_numero
   	 				@seasons << Season.find_by_id(e.season_id)
   	 			end
   	 			e_numero = 0
   	 		
   	 		else
   	 		e_numero = e_numero+1
   	 		end
   	 	end

    end

    #full series
    def set_series
 		@series = []
    	actual_id = -1
    	previous_id= -1
    	actual_e_series=0
    	e_numero=0
   	 	@seasons.sort {|a,b| a.serial_id <=> b.serial_id}.each do |e|
   	 		actual_id = e.serial_id
   	 		
   	 		if(e.serial_id!=previous_id)
   	 			previous_id = actual_id
   	 			if (Serial.find_by_id(e.serial_id).seasons.size <= e_numero)
   	 				@series << Serial.find_by_id(e.serial_id)
   	 				
   	 			end
   	 		e_numero = 0
   	 		else
   	 		e_numero = e_numero+1
   	 		end
   	 	end

    end



    # Never trust parameters from the scary internet, only allow the white list through.
    def watched_params
      params.require(:watched).permit(:user_id)
    end

end
