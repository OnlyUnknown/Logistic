class Api::V1::FsupervisorController < ApplicationController
  before_action :authenticate_supervisor!
  before_action :set_user, only: %i[add added? remove]

  def under_supervision
    render json: current_supervisor.all_following
  end

  def add
    if current_supervisor.following?(@user) == true
      render json: { message: "The #{@user.name} agent is under your supervision" }

    elsif current_supervisor.follow(@user) && @user.follow(current_supervisor)
      render json: { message: "The #{@user.name} agent has been added to the list of the supervision" }
    else
      render json: { message: 'Something went wrong' }
    end
  end

  def added?
    render json: current_supervisor.following?(@user)
  end

  def remove
    if current_supervisor.following?(@user) == false
      render json: { message: "The #{@user.name} agent isn't under your supervision" }
    elsif current_supervisor.stop_following(@user) && @user.stop_following(current_supervisor)
      render json: { message: "The #{@user.name} agent is deleted from the list of the supervision" }
    else
      render json: { message: 'something went wrong' }
    end
  end

  def add_count
    @list = current_supervisor.follow_count
    render json: @list
  end

  private

  def set_user
    @user = Agent.find(params[:id])
  end
end
