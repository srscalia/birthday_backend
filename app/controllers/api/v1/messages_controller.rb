class Api::V1::MessagesController < ApplicationController
  # before_action :authenticate_user
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

    if @message
      account_sid = ENV['ACCOUNT_SID']
      auth_token = ENV['AUTH_TOKEN']

      @client = Twilio::REST::Client.new(account_sid, auth_token)
      message = @client.messages
      .create(
        body: "#{@message.content} --- From #{@message.reminder.user.first_name} #{@message.reminder.user.last_name}",
        from: '+13479976723',
        media_url: 'https://images.unsplash.com/photo-1464349153735-7db50ed83c84?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=200&q=160',
        to: '+19702759707'
      )

      render json: @message, status: :created
    end
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
