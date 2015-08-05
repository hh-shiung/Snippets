class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]


  # GET /users
  # GET /users.json
  def index
    @users = User.all
    puts @users.first.id
    puts "User ID hEre"
  end

  def showIndex
    # Snippets::Application::MaxPostInADay
    # Refer to config/application.rb for Global Static Variable
    if (params[:email] != nil)

    cookies[:current_user_email] = params[:email]

    @personaluserid =  User.find_by(email: cookies[:current_user_email])
    puts @personaluserid.username
    cookies[:current_username] = @personaluserid.username
    puts @personaluserid.avatar
    cookies[:current_avatar] = @personaluserid.avatar


    end

    if(User.exists?(email: cookies[:current_user_email]))
      # Do nothing. Continue
    else
      flash[:invaliduser] = "#{params[:email]} does not exist. Have you registered?"
      redirect_to "/login" and return
    end


    @welcomemsg = "Welcome #{cookies[:current_user_email]}"

    @snippets = Snippet.all.order(snippet_view_count: :desc)
		render template: 'landing/index'
	end

  def showLogin
    render template: 'users/login'
  end

  def showLock
    render template: 'users/lock_screen'
  end

  def showPersonal
    puts cookies[:current_user_email]

    @personaluserid =  User.find_by(email: cookies[:current_user_email])
    puts @personaluserid.email
    puts @personaluserid.username
    @personalsnippets = Snippet.all.where(user_id: @personaluserid.id)
    render template: 'users/personal'
  end

  def showFav
    @username =

    render template: 'favorites/fav'
  end

  def showPerformance

    render template: 'users/performance'
  end

  def sendEmail
    # user = User.find_by(name: "Bryan Lim")
    # UserMailer.welcome(user).deliver
    require 'SecureRandom'
    @email = params[:email]
    @password = params[:login_pass]
    @token = SecureRandom.hex
    # @email = ""
    @is_activate = 0
    UserMailer.welcome(@email,@token).deliver
    object = User.new(:email => @email, :password => @password, :token => @token, :is_email_confirm => 0)
    object.save
    render template: "test/blank"
  end

  def verifyToken
    @token = params[:token]
    # user = User.find_by(token: token)
    # if(user)
    #   # user.update_all({:is_activate => 1, :token => nil})
    #   User.where(:id => user.id).update_all({:is_activate => true, :token => nil})
    #   user.save
    #   @is_success = 1
    #   @email_Address = user.email
    # else
    #     @is_success = 0
    # end
    render template: 'test/blank'
  end

  def getinput
    @input_email = params[:email]
    @input_password = params[:password]
    @input_first_name = params[:first_name]
    @input_last_name = params[:last_name]

    render template: 'test/blank'
  end
  # GET /users/1
  # GET /users/1.json
  def show
    @users = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
    redirect_to "/login"
    end

    # respond_to do |format|
    #   if @user.save
    #     # format.html { redirect_to @user, notice: 'User was successfully created.' }
    #     # format.json { render :show, status: :created, location: @user }
    #     render template: 'users/login'
    #   else
    #     format.html { render :new }
    #     format.json { render json: @user.errors, status: :unprocessable_entity }
    #   end
    # end
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
    respond_to do |format|
      if @user.update(user_params)
        format.html { redirect_to @user, notice: 'User was successfully updated.' }
        format.json { render :show, status: :ok, location: @user }
      else
        format.html { render :edit }
        format.json { render json: @user.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
    @user.destroy
    respond_to do |format|
      format.html { redirect_to users_url, notice: 'User was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :first_name, :last_name, :email, :password, :avatar)
    end
end
