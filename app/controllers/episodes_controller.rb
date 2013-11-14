class EpisodesController < ApplicationController
  skip_before_filter :user_admin, only: [:show, :index, :add_user_tags, :remove_user_tag, :seen, :unseen]
  skip_before_filter :authorize, only: [:show, :index]
  before_action :set_season_serial
  before_action :set_episode, only: [:show, :edit, :update, :destroy, :add_user_tags, :remove_user_tag, :seen, :unseen]
  before_action :set_reviews, only:[:show]
  before_action :set_posts, only:[:show]

  # GET /episodes
  # GET /episodes.json
  def index
    @episodes = @season.episodes
  end

  # GET /episodes/1
  # GET /episodes/1.json
  def show
  end

  # GET /episodes/new
  def new
    @episode = Episode.new
  end

  # GET /episodes/1/edit
  def edit
  end

  # POST /episodes
  # POST /episodes.json
  def create
    param_tags = params[:episode][:tags_list]
    params[:episode].delete(:tags_list)
    @episode = Episode.new(episode_params)
    @episode.season_id = @season.id
    @episode.update_tags(param_tags, @episode)



    respond_to do |format|
      if @episode.save
        series = Serial.find_by_id(@season.serial_id)
        User.all.each do |u|
        if u.serials.include?(series)
          #UserMailer.new_episode(u).deliver
        end
        end
        format.html { redirect_to [@serial,@season,@episode], notice: 'Episode was successfully created.' }
        format.json { render action: 'show', status: :created, location: @episode }
      else
        format.html { render action: 'new' }
        format.json { render json: @episode.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /episodes/1
  # PATCH/PUT /episodes/1.json
  def update
    param_tags = params[:episode][:tags_list]
    params[:episode].delete(:tags_list)
    @episode.update_tags(param_tags, @episode)
        
    respond_to do |format|
      if @episode.update(episode_params)
        format.html { redirect_to [@serial,@season,@episode], notice: 'Episode was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @episode.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /episodes/1
  # DELETE /episodes/1.json
  def destroy
    @episode.destroy
    respond_to do |format|
      format.html { redirect_to serial_season_episodes_url }
      format.json { head :no_content }
    end
  end


 def seen
    if current_user
      if current_user.watched.episodes.include?(@episode)
        redirect_to serial_season_episode_url(@serial,@season,@episode), notice: "You already marked this episode as seen!"
      else
        current_user.watched.episodes << @episode
        current_user.score += 2
        current_user.save
        redirect_to serial_season_episode_url(@serial,@season,@episode), notice: "#{@episode.name} was successfully marked as seen!"
      end
    end
  end

    def unseen
    if current_user
      if current_user.watched.episodes.include?(@episode)
        current_user.watched.episodes.delete(@episode)
        current_user.score -=2
        current_user.save
        redirect_to serial_season_episode_url(@serial,@season,@episode), notice: "#{@episode.name} was successfully marked as unseen!"
      else
        redirect_to serial_season_episode_url(@serial,@season,@episode), notice: "You can't unseen #{@episode.name}, D'OH!!!"
      end
    end
    end




  def add_user_tags
    if current_user
      @episode.update_user_tags(params[:user_tags_list], @episode, current_user)
      redirect_to serial_season_episode_url(@serial,@season,@episode), notice: "Your tags were added!"
    else 
      redirect_to access_denied_path
    end
  end

  def remove_user_tag
    if current_user
      if @episode.user_user_tags(current_user).include?(Tag.find_by(name: params[:tag_id]))
        @episode.remove_user_tag(params[:tag_id],@episode,current_user)
        redirect_to serial_season_episode_url(@serial,@season,@episode), notice: "Your tag \"#{params[:tag_id]}\" has been removed"
      else
        redirect_to serial_season_episode_url(@serial,@season,@episode), notice: "Whoah, trying to get rid of something you don't have? Nope"
      end
    else 
      redirect_to access_denied_path
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_episode
      @episode = @season.episodes.find_by(number: params[:id])
    end

    def set_season_serial
      @serial = Serial.find(params[:serial_id])
      @season = @serial.seasons.find_by(number: params[:season_id])
    end

    def set_reviews
      @reviews = @episode.reviews
    end

    def set_posts
      @posts = @episode.posts
      @post = Post.new
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def episode_params
      params.require(:episode).permit(:name, :description, :date, :number, :write, :director, :duration, :season_id, :tag_list)
    end
end
