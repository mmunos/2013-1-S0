class WatchedController < ApplicationController
  skip_before_filter :user_admin, only: [ :my_watched]
  before_action :set_watched
  before_action :set_seasons
  before_action :set_series
  before_action :set_watching


 

  def my_watched
    if current_user
    	@user = current_user
      @watched = current_user.watched
      render action: 'show'
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
    	@seasons_unf=[]
    	actual_id = -1
    	previous_id= -1
    	e_numero=1
   	 	@watched.episodes.sort {|a,b| a.season_id <=> b.season_id}.each do |e|
   	 		actual_id = e.season_id
   			e_numero = e_numero + 1
   	 		if(actual_id!=previous_id)
   	 			e_numero = 1
   	 			if Season.find_by_id(e.season_id).episodes.size <= e_numero
   	 				@seasons << Season.find_by_id(e.season_id)

   	 			else
   	 				@seasons_unf << Season.find_by_id(e.season_id)
   	 			end
   	 			
   	 		
   	 		
   	 		
   	 		end
   	 		previous_id = actual_id
   	 	end

    end

    #full series
    def set_series
 		@series = []
    	actual_id = -1
    	previous_id= -1
    	e_numero=1
   	 	@seasons.sort {|a,b| a.serial_id <=> b.serial_id}.each do |e|
   	 		actual_id = e.serial_id
   	 		e_numero=e_numero + 1
   	 		
   	 		if(e.serial_id!=previous_id )
   	 			e_numero = 1
   	 			if (Serial.find_by_id(e.serial_id).seasons.size <= e_numero)
   	 				@series << Serial.find_by_id(e.serial_id)
   	 				
   	 			end
   	 		
   	 		
   	 		
   	 		end
   	 		previous_id = actual_id
   	 	end

    end

        #full series
    def set_watching
 		@watching = []
    	actual_id = -1
    	previous_id= -1
   	 	@seasons_unf.sort {|a,b| a.serial_id <=> b.serial_id}.each do |e|
   	 		actual_id = e.serial_id
   	 		
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
