class Api::V1::UsersController < ApplicationController
  # before_action :authenticate_v1_user, only: [:current, :index, :show, :update, :destroy]
  before_action :find_user, only: [:show, :update, :destroy]

  def current
    render json: current_user.as_json(only: %i(id email))
  end

  def index
    @users = User.all
    render json: @users, status: :ok
  end

  def show
    render json: @user, status: :ok
  end

  def create
    @user = User.create(user_params)
    render json: @user, status: :created
  end

  def update
    @user.update(user_params)

    if @user.save
      render json: @user, status: :accepted
    else
      render json: { errors: @user.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def destroy
    @user.destroy
  end


  private

  def user_params
    params.require(:user).permit(:first_name, :last_name, :email, :phone, :password, :password_confirmation)
  end

  def find_user
    @user = User.find(params[:id])
  end
end ### End of UsersController
