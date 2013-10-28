class SerialsController < ApplicationController
  skip_before_filter :user_admin, only: [:show, :index, :add, :remove]
  skip_before_filter :authorize, only: [:show, :index]
  before_action :set_serial, only: [:show, :edit, :update, :destroy, :add, :remove, :watch, :no_watch]
  before_action :set_parent, only:[:show, :index]
  before_action :set_reviews, only:[:show]

  # GET /serials
  # GET /serials.json
  def index
    @serials = Serial.all
  end

  # GET /serials/1
  # GET /serials/1.json
  def show
  end

  # GET /serials/new
  def new
    @serial = Serial.new
  end

  # GET /serials/1/edit
  def edit
  end

  # POST /serials
  # POST /serials.json
  def create
    @serial = Serial.new(serial_params)

    respond_to do |format|
      if @serial.save
        format.html { redirect_to @serial, notice: 'Serial was successfully created.' }
        format.json { render action: 'show', status: :created, location: @serial }
      else
        format.html { render action: 'new' }
        format.json { render json: @serial.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /serials/1
  # PATCH/PUT /serials/1.json
  def update
    respond_to do |format|
      if @serial.update(serial_params)
        format.html { redirect_to @serial, notice: 'Serial was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @serial.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /serials/1
  # DELETE /serials/1.json
  def destroy
    @serial.destroy
    respond_to do |format|
      format.html { redirect_to serials_url }
      format.json { head :no_content }
    end
  end

  def add
    if current_user
      if current_user.serials.include?(@serial)
        redirect_to @serial, notice: "You already follow this series"
      else
        current_user.serials << @serial
        redirect_to @serial, notice: "#{@serial.name} was successfully added!"
      end
    end
  end

  def remove
    if current_user
      if current_user.serials.include?(@serial)
        current_user.serials.delete(@serial)
        redirect_to @serial, notice: "#{@serial.name} was successfully removed!"
      else
        redirect_to @serial, notice: "You can't delete #{@serial.name}, D'OH!!!"
      end
    end
  end

    def watch
    if current_user
      if current_user.watchlist.serials.include?(@serial)
        redirect_to @serial, notice: "You already added this series to your watchlist"
      else
        current_user.watchlist.serials << @serial
        redirect_to @serial, notice: "#{@serial.name} was successfully added to watchlist!"
      end
    end
  end

    def no_watch
    if current_user
      if current_user.watchlist.serials.include?(@serial)
        current_user.watchlist.serials.delete(@serial)
        redirect_to @serial, notice: "#{@serial.name} was successfully removed from watchlist!"
      else
        redirect_to @serial, notice: "You can't delete #{@serial.name} from watchlist, D'OH!!!"
      end
    end
  end


  private
    # Use callbacks to share common setup or constraints between actions.
    def set_serial
      @serial = Serial.find(params[:id])
    end

    def set_reviews
      @reviews = @serial.reviews
    end

    def set_parent
      @parent = find_parent_models(@serial)[0..-1]
    end


    # Never trust parameters from the scary internet, only allow the white list through.
    def serial_params
      params.require(:serial).permit(:name, :date, :genre, :description)
    end
end
