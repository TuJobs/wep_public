class UsersController < ApplicationController
  before_action :logged_in_user, except: [:show, :new, :create]
  before_action :correct_user, only: [:edit, :update]
  before_action :admin_user, only: :destroy

  def index
    @users = User.paginate page: params[:page], per_page: Settings.user.per_page
  end

  def show
    @user = User.find_by id: params[:id]
    @posts = @user.posts.paginate page: params[:page],
      per_page: Settings.user.per_page
  end

  def new
    @user = User.new
  end

  def create
    @user = User.new user_params

    if @user.save
      log_in @user
      flash[:success] = t ".welcome"
      redirect_to @user
    else
      render :new
    end
  end

  def edit
    @user = User.find_by id: params[:id]
  end

  def update
    @user = User.find_by id: params[:id]

    if @user.update_attributes user_params
      flash[:success] = t ".profile_updated"
      redirect_to @user
    else
      render :edit
    end
  end

  def destroy
    User.find(params[:id]).destroy
    flash[:success] = t ".delete_user"
    redirect_to users_url
  end

  def following
    @title = "Following"
    @user  = User.find_by id: params[:id]
    @users = @user.following.paginate  page: params[:page], per_page: 10
    render :show_follow
  end

  def followers
    @title = "Followers"
    @user  = User.find_by id: params[:id]
    @users = @user.followers.paginate page: params[:page] , per_page: 10
    render :show_follow
  end

  private

  def user_params
    params.require(:user).permit :name, :email, :password, :password_confirmation
  end

  def correct_user
    @user = User.find_by id: params[:id]
    redirect_to root_url unless current_user? @user
  end

  def admin_user
    redirect_to root_url unless current_user.is_admin?
  end
end
