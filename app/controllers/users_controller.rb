require 'bcrypt' 

class UsersController < ApplicationController
  def new
  end

  def show
    @user = User.find(params[:id])
  end

  def create
    @user = User.new(user_params)
    encrypt(@user.encrypted_password)
    if @user.save
      session[:user_id] = @user.id
      redirect_to '/'
    else
      redirect_to '/users/new'
    end
  end

  def edit
    @user = User.find(params[:id])
  end

  def update
    @user = User.find(params[:id])
    if @user.update(user_params)
      redirect_to '/'
    else
      render 'edit'
    end
  end

  private

  def user_params
    p params
    params.require(:user).permit(:username, :email, :encrypted_password)
  end

  def encrypt(password)
    salt = BCrypt::Engine.generate_salt
    encrypted_password = BCrypt::Engine.hash_secret(password, salt)
  end

end
