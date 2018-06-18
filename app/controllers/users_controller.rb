class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :logged_in_user, only: [:index, :edit, :update, :destroy]
  before_action :authorize_user, only: [:edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.where(activated: true).paginate(page: params[:page], per_page: 10)
  end

  # GET /users/1
  # GET /users/1.json
  def show
    redirect_to root_url and return if !@user.activated?
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
    if @user.save
      @user.send_activation_email
      flash[:info] = "Please check your email to activate your account."
      redirect_to root_url
    else
      render :new
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update

    if @user.update_attributes(user_params)
      log_in(@user) if current_user?(@user)
      flash[:success] = "Account succesfully updated."
      redirect_to @user
    else
      flash[:danger] = "We couldn't update your account."
      redirect_to edit_user_path(@user)
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    own_acct = current_user?(@user)
    @user.destroy
    if own_acct
      flash[:success] = "Your account has been succesfully deleted."
      redirect_to root_path
    else
      flash[:success] = "Account succesfully deleted."
      redirect_to users_path
    end

  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      username = params[:username]
      if User.exists?(username: username)
        @user = User.find_by(username: username)
      else
        render "application/404"
      end
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :email, :password, :password_confirmation)
    end

    # Confirms a logged-in user.
    def logged_in_user
      unless logged_in?
        store_location
        flash[:danger] = "Please log in."
        redirect_to login_url
      end
    end

    def authorize_user
      unless current_user?(@user) || is_admin?
        redirect_to root_url
      end
    end
end
