class Api::V1::RemindersController < ApplicationController
  before_action :authenticate_user
  before_action :find_reminder, only: [:show, :update, :destroy]

  def index
    @reminders = Reminder.all
    render json: @reminders, status: :ok
  end

  def show
    render json: @reminder, status: :ok
  end

  def create
    @reminder = Reminder.create(reminder_params)
    render json: @reminder, status: :created
  end

  def update
    @reminder.update(reminder_params)

    if @reminder.save
      render json: @reminder, status: :accepted
    else
      render json: { errors: @reminder.errors.full_messages }, status: :unprocessible_entity
    end
  end

  def destroy
    @reminder.destroy
  end


  private

  def reminder_params
    params.require(:reminder).permit(:user_id, :relation, :birthday, :person_name, :send_reminder, :phone, :notes)
  end

  def find_reminder
    @reminder = Reminder.find(params[:id])
  end
end ### End of RemindersController
