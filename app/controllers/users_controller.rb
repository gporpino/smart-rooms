class UsersController < ApplicationController
  load_and_authorize_resource
  skip_authorization_check :only => [:new, :create]

  # GET /users/1
  # GET /users/1.json
  def show
    @myrooms = Room.where(owner: current_user).paginate(:page => params[:page], :per_page => 3)
    @belongsrooms = Room.includes(:users).where(users: { id: current_user.id}).paginate(:page => params[:page], :per_page => 3)
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
    @user = params[:user] ? User.new(user_params) : User.new_guest

    respond_to do |format|
      if @user.save
        current_user.move_to(@user) if current_user && current_user.guest?
        sign_in @user
        format.html { redirect_to @user, :flash => { success: 'User was successfully created. Welcome!' } }
        format.json { render action: 'show', status: :created, location: @user }
      else
        format.html { render action: 'new' }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, :flash => { success: 'User was successfully updated.' } }
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
      format.html { redirect_to users_url, :flash => { success: 'User was successfully destroyed.' }  }
      format.json { head :no_content }
    end
  end

  private

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:name, :email, :password, :password_confirmation)
    end
end
