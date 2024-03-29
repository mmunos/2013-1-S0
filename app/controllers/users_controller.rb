class UsersController < ApplicationController
  skip_before_filter :authorize, only: [:show, :new, :create]
  skip_before_filter :user_admin, only: [:show, :edit, :update, :me]
  before_action :can_edit, only: [:edit, :update] 
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
  end

  # GET /users/1
  # GET /users/1.json
  def show
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if user_admin?(current_user)
      @user.role = params[:user][:role]
    else
      @user.role = "user"
    end

    @user.score = 0

    respond_to do |format|
      if @user.save
         # Tell the UserMailer to send a welcome Email after save
        #UserMailer.welcome_email(@user).deliver
        format.html { redirect_to @user, notice: 'User was successfully created.' }
        format.json { render action: 'show', status: :created, location: @user }
        if !user_admin?(current_user)
          session[:user_id] = @user.id
        end
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    if user_admin?(current_user)
      @user.role = params[:user][:role]
      @user.score = params[:user][:score]
    end

    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { head :no_content }
      else
        format.html { render action: 'edit' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url }
      format.json { head :no_content }
    end
  end

  def me
    redirect_to current_user
  end


  private
    def can_edit
      unless user_admin?(current_user) || current_user == User.find(params[:id])
        redirect_to access_denied_path, notice: "You can't edit other user's profile!" 
      end
    end

    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :username, :email, :password, :password_confirmation)
    end
end
