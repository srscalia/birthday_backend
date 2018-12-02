class Api::V1::MessagesController < ApplicationController
  before_action :authenticate_v1_user
  before_action :find_message, only: [:show, :update, :destroy]

  def index
    @messages = Message.all
    render json: @messages, status: :ok
  end

  def show
    render json: @message, status: :ok
  end

  def create
    @message = Message.create(message_params)
    render json: @message, status: :created
  end

  def update
    @message.update(message_params)

    if @message.save
      render json: @message, status: :accepted
    else
      render json: { errors: @message.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def destroy
    @message.destroy
  end


  private

  def message_params
    params.require(:message).permit(:reminder_id, :content)
  end

  def find_message
    @message = Message.find(params[:id])
  end
end ## End of MessagesController
