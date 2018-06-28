class UsersController < ApplicationController
  before_action :logged_in_user , only: [:show, :edit, :update, :destroy , :index]
  before_action :correct_user , only: [:edit , :update ]
  before_action :admin_user , only: [:destroy]
  # GET /users
  # GET /users.json
  def index
    @users = User.paginate(page: params[:page])
  end

  # GET /users/1
  # GET /users/1.json
  def show
    @user = User.find_by(id: params[:id])
    @micropost = @user.microposts.first
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find_by(id: params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)

    if @user.save
      log_in @user
      flash[:success] = "Welcome !"
      redirect_to @user
    else
      render "new"
    end
   # respond_to do |format|
    #  if @user.save
     #   format.html { redirect_to @user, notice: 'User was successfully created.' }
      #  format.json { render :show, status: :created, location: @user }
      #else
       # format.html { render :new }
       # format.json { render json: @user.errors, status: :unprocessable_entity }
      #end
   # end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    @user = User.find_by(id: params[:id])
    if @user.update_attributes(user_params)
      flash[:success] = "Profile updated."
      redirect_to @user
    else
      render 'edit'
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user = User.find_by(id: params[:id])
    @user.destroy
    flash.now[:success] = "User is deleted."
    redirect_to users_url
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_user
    @user = User.find_by(id: params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def user_params
    params.require(:user).permit(:name, :email , :password, :password_confirmation )
  end

  def logged_in_user
    unless logged_in?
      flash[:danger] = "Please log in."
      redirect_to login_url
    end
  end

  def correct_user
    @user = User.find_by(id: params[:id])
    redirect_to root_url unless @user == current_user
  end

  def admin_user
    redirect_to root_url unless current_user.admin?
  end
end
