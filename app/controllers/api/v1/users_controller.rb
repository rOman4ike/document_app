class Api::V1::UsersController < ApplicationController
  # before_action :set_user, only: %i[ show edit update destroy sign_in ]

  def create
    @user = User.find_by(email: params[:email])
    if @user && @user.authenticate(params[:password])
      if params[:remember_me]
        cookies.permanent[:remember_token] = @user.remember_token
      else
        session[:user_id] = @user.id
      end
      render json: @user, status: :ok
    else
      render json: { error: 'Invalid email or password' }, status: :unauthorized
    end
  end

  private

  def set_user
    @user = User.find(params[:id])
  end

  def user_params
    params.require(:user).permit(:email, :password)
  end
end
