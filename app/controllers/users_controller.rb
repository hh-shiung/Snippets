class UsersController < ApplicationController

  layout 'dashboard_layout', except: [:showLogin, :showLogout, :new]

  before_action :set_user, only: [:show, :edit, :update, :destroy]
  before_action :auth_user
  skip_before_action :auth_user, only: [:new, :create, :showLogin, :fbcreate]
  skip_before_filter :verify_authenticity_token, :only => [:index, :show, :showIndex]
  before_filter :check_for_cancel, :only => [:create, :update, :fbcreate]
  # GET /users
  # GET /users.json
  def index
    @users = User.all
    puts @users.first.id
    puts "User ID here"
  end

  def check_for_cancel
    puts "Entering Cancel"
  if params.key?("cancel")
    puts "Cancel"
    redirect_to "/"
  end
  end

  def Home
    redirect_to "/"
  end

  def showIndex
    # Snippets::Application::MaxPostInADay
    # Refer to config/application.rb for Global Static Variable

    @welcomemsg = "Welcome #{session[:current_user_email]}"
    @snippets = Snippet.all.order(snippet_view_count: :desc)
    render template: 'landing/index'
  end

  def showLogin
    render template: 'users/login'
  end

  def showLogout
    puts "Clear sessions"
    session.clear
    puts session[:current_user_email]
    # flash[:invaliduser] = "You've logged out from RoRSnippet"
    flash[:notice] = "You have logged out from RoRSnippets"
    redirect_to "/login"
  end

  def showLock
    render template: 'users/lock_screen'
  end

  def showPersonal
    puts session[:current_user_email]
    puts "showPersonal"
    @personaluserid =  User.find_by(email: session[:current_user_email])
    @personalsnippets = Snippet.all.where(user_id: @personaluserid.id)

    @welcomemsg = "#{@personaluserid.username}'s personal snippets collection"
    render template: 'users/personal'
  end

  def showFav
    render template: 'favorites/fav'
  end

  def showPerformance
    render template: 'users/performance'
  end

  def forgotPW
    # render template: 'test/blank'
    # email = params[:email]
    require 'SecureRandom'
    input_email = params[:email]
    token = SecureRandom.urlsafe_base64
    result = sendEmail(input_email,token,'forgotpw')
    # render json: @product
    render status: 200, json: result and return
  end

  def sendEmail(email,token,type)
    # user = User.find_by(name: "Bryan Lim")
    # UserMailer.welcome(user).deliver
    # @email = params[:email]
    # @password = params[:login_pass]
    # @email = ""
    # @is_activate = 0
    if type == "forgotpw"
      result = User.find_by_email("#{email}")
      if result == nil
        result = ["is_success"=>"0"]
        return result
      else
        require 'SecureRandom'
        @password = SecureRandom.urlsafe_base64
        UserMailer.forgotpw(email,token,@password).deliver
        User.update(result.id, :password=>@password)
        # Person.update(15, :user_name => 'Samuel', :group => 'expert')
        # people = { 1 => { "first_name" => "David" }, 2 => { "first_name" => "Jeremy" } }
        # Person.update(people.keys, people.values)
        result = ["is_success" => "1"]

        return result
      end
    elsif type == "welcome"
      UserMailer.welcome(email,token).deliver
    end
    # object = User.new(:email => @email, :password => @password, :token => @token, :is_email_confirm => 0)
    # object.save
    # render template: "test/blank"
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
    @xxx = "XXX"
    render status: 200, plain: @xxx
    # render template: 'test/blank'
  end

  def forgotPW

  end
  # GET /users/1
  # GET /users/1.json
  def show
    @users = User.find(params[:id])
  end

  # GET /users/new
  def new
    @user = User.new
    puts "Alert"
    puts session[:alert]
  end

  # GET /users/1/edit
  def edit
    @user = User.find(params[:id])
  end

  def fbcreate
    puts "fbcreate"
    if env['omniauth.auth']
      puts env['omniauth.auth']
      @fbinfo = env['omniauth.auth']['info']
      @userexist = User.find_by(email: @fbinfo.email)
      if @userexist
        session[:current_user_email] = @fbinfo.email
        redirect_to "/index"
      else
      puts @fbinfo
        @user = User.new(username: @fbinfo.name,
                    first_name: "",
                    last_name: "",
                    email: @fbinfo.email,
                    password: Devise.friendly_token.first(8),
                    avatar: @fbinfo.image
                         )
        puts "User created thru FB"
        puts @user
        if @user.save
          session[:current_user_email] = @fbinfo.email
        redirect_to "/index"
        else
          puts @user.errors.full_messages
          flash[:alert] = @user.errors.full_messages
          puts flash[:alert]
          redirect_to "/login"
        end
      end
    end
  end

  # POST /users
  # POST /users.json
  def create
    @user = User.new(user_params)
    if @user.save
      flash[:notice] = "Thank you for registering. Please check your inbox for confirmation email."
    redirect_to "/login"
    else
      puts @user.errors.full_messages
      flash[:alert] = @user.errors.full_messages
      puts flash[:alert]
      redirect_to "/register"
    end
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
  def auth_user
    if(params[:email] != nil && params[:password] != nil)
      @verify = User.find_by(email: params[:email])
      if(!@verify.blank? && @verify.valid_password?(params[:password]))
        puts "Password: #{params[:password]}"
        puts "Password check : #{@verify.valid_password?(params[:password])}"
        session.clear
        session[:current_user_email] = params[:email]
        @personaluserid =  User.find_by(email: params[:email])
        session[:current_username] = @personaluserid.username
        session[:current_avatar] = @personaluserid.avatar.url(:thumb)
      else
        # flash[:invaliduser] = "Invalid Email and/or Password."
        flash[:alert] = "Invalid Email and/or Password."
        redirect_to "/login" and return
      end
    elsif(session.has_key?("current_user_email"))
          @verify = User.find_by(email: session[:current_user_email])
          if(!@verify.blank?)
            session[:current_user_email] = @verify.email
            session[:current_username] = @verify.username
            session[:current_avatar] = @verify.avatar.url(:thumb)
          end

        else
          flash[:alert] = "You must be logged in to access this section."
            redirect_to "/login" and return
        end

  end
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:username, :first_name, :last_name, :email, :password, :avatar)
    end
end
