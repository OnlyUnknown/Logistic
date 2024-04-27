class Api::V1::SprofileController < ApplicationController
    before_action :authenticate_supervisor!

   before_action  :set_supervisor, only: [:follow, :accept, :cancel, :decline, :unfollow] 
    def show_followers
        render json: current_supervisor.followers
    end

    def follow_request
        if current_supervisor
          render json: current_supervisor.follow_requests
        else
          render json: { error: "No user found" }, status: :unprocessable_entity
        end
      end
      

    def pending
        render json: current_supervisor.pending_requests
    end
    
    def follow
        if current_supervisor.send_follow_request_to(@user)
        render json: { message: 'follow request sent successfully' }
    else
    render json: current_supervisor.errors.full_messages
    end
    end
    
    def unfollow
        make_it_a_unfriend_request
        if current_supervisor.unfollow(@user)
            render json: { message: 'the user has been unfollowed successfully' }
        else
            render json: current_supervisor.errors.full_messages
        end
    end

    def accept
        if current_supervisor.accept_follow_request_of(@user)
        make_it_a_friend_request
        render json: { message: 'The follow requested has been accepted successfully' }
    else
        render json: current_supervisor.errors.full_messages
        end

    end

    def decline
        if current_supervisor.decline_follow_request_of(@user)
            render json: { message: 'The follow request has been declined successfully' }
    else
        render json: current_supervisor.errors.full_messages
        end
    end

    def cancel
        if current_supervisor.remove_follow_request_for(@user)
            render json: { message: 'follow request removed successfully' }
        else
        render json: current_supervisor.errors.full_messages
        end
    end

    private

    def make_it_a_friend_request
        current_supervisor.send_follow_request_to(@user)
        @user.accept_follow_request_of(current_supervisor)
    end

    def make_it_a_unfriend_request
        @user.unfollow(current_supervisor) if @user.mutal_following_with?(current_supervisor)
    end

    def set_supervisor
        @num = first_digit(params[:id].to_i.abs)
          if @num == 1
        @user = Supervisor.find(params[:id])
          elsif @num == 2
            @user = Agent.find(params[:id])
            else
                @user = Customer.find(params[:id])
            end
    end

    def first_digit(number)
        number.to_s[0].to_i
      end

end
