class WatchedController < ApplicationController
  skip_before_filter :user_admin, only: [ :my_watched, :movies, :tracking, :detail, :series]
  before_action :set_watched
  before_action :set_seasons
  before_action :set_series
  before_action :set_watching
  before_action :set_serial, only: [:tracking]


 

  def my_watched
    if current_user
    	@user = current_user
      @watched = current_user.watched
      render action: 'show'
    end
  end

  def movies
    if current_user
      @user = current_user
      @watched = current_user.watched
      render action: 'movies'
    end
  end

    def series
    if current_user
      @user = current_user
      @watched = current_user.watched
      render action: 'serials'
    end
  end


 def tracking
      @user = current_user
      @watched = current_user.watched
    render action: 'tracking'
  end

   def detail
      @user = current_user
      @watched = current_user.watched
      @serial = Serial.find(params[:serial_id])
      @season = @serial.seasons.find_by(number: params[:season_id])
    render action: 'detail'
  end


    def set_serial
      @serial = Serial.find(params[:id])
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
    	@seasons_unf=[]
    	season_all = []

   	 	@watched.episodes.sort {|a,b| a.season_id <=> b.season_id}.each do |e|  	 		
   	 		unless season_all.include?(Season.find_by_id(e.season_id))
   	 			season_all<<Season.find_by_id(e.season_id)
   	 		end	
   	 		
   	 	end

   	 	season_all.each do |s|
   	 		season=[]
    	se = Season.find_by_id(s.id)
    	@watched.episodes.sort {|a,b| a.season_id <=> b.season_id}.each do |e|
    		if e.season_id == se.id
    			season<<e
    		end
    	end

	 		if s.episodes.size <= season.size
	 			@seasons << s

	 		else
	 			@seasons_unf << s
	 		end

   	 	end



    end

    #full series
    def set_series
 		@series = []
 		series_all=[]
   	 		
   	 	@seasons.sort {|a,b| a.serial_id <=> b.serial_id}.each do |e|  	 		
   	 		unless series_all.include?(Serial.find_by_id(e.serial_id))
   	 			series_all<<Serial.find_by_id(e.serial_id)
   	 		end	
   	 		
   	 	end

   		series_all.each do |s|
   	 		series=[]
    		se = Serial.find_by_id(s.id)
    		@seasons.sort {|a,b| a.serial_id <=> b.serial_id}.each do |e|
    			if e.serial_id == se.id
    				series<<e
    			end
    		end
   	 			if (s.seasons.size <= series.size)
   	 				@series << Serial.find_by_id(s.id)
   	 				
   	 			end
   	 		
   	 	end
   	 	

    end

        #full series
    def set_watching
 		@watching = []
   	 	@seasons_unf.sort {|a,b| a.serial_id <=> b.serial_id}.each do |e|
 
   	 		
   	 		unless @watching.include?(Serial.find_by_id(e.serial_id))
					@watching << Serial.find_by_id(e.serial_id)   	 				

   	 		end
   	 	end

    end



    # Never trust parameters from the scary internet, only allow the white list through.
    def watched_params
      params.require(:watched).permit(:user_id)
    end

end
