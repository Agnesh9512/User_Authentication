class UsersController < ApplicationController

  # used for using cancan
  # load_and_authorize_resource

  def index
    @users = User.all
    @products = Product.all
    authorize @users
    respond_to do |format|
      format.html # index.html.erb
      format.xml { render xml: @users }
    end

    # @user = User.friendly.find(params[:id])
    # authorize @user

    # if current_user.has_role? :admin
    #   @users = User.all
    # else
    #   redirect_to root_path, alert: "You don't have access to show users list"
    # end
    # @users = User.all
  end

  def edit
    @user = User.friendly.find(params[:id])
    authorize @user
    # if @user.admin?
    #   @user.update(user_params)
    # else
    #   render :edit
    # end
  end

  def update
    @user = User.friendly.find(params[:id])
    authorize @user
    if @user.update(user_params)
      redirect_to users_url, notice: 'User was successfully updated.'
    else
      render :edit, status: :unprocessable_entity
    end
    p @user
  end

  def destroy
    @user = User.friendly.find(params[:id])
    authorize @user
    @user.destroy
    redirect_to users_path
  end

  private

  def user_params
    params.require(:user).permit({ role_ids: [] })
  end
end
