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
    render json: @message, status: :created

    if @message
      account_sid = 'AC5ef872f6da5a21de157d80997a64bd33'
      auth_token = '[AuthToken]'
      # set up a client to talk to the Twilio REST API
      @client = Twilio::REST::Client.new account_sid, auth_token
      @client.account.messages.create({
        :from => '+14158141829',
        :to => '+16518675309',
        :body => 'Tomorrow\'s forecast in Financial District, San Francisco is Clear.',
        :media_url => 'https://climacons.herokuapp.com/clear.png'
      })

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
