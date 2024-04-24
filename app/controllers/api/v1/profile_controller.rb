class Api::V1::ProfileController < ApplicationController
    before_action :authenticate_supervisor!
   before_action :set_supervisor, except: [:pending, :show_followers] 
    def show_followers
        render json: current_supervisor.followers
    end

    def follow_request
        render json: current_supervisor.follow_requests
    end

    def pending
        render json: current_supervisor.pending_requests
    end

   

    def follow
        if current_supervisor.send_follow_request_to(@supervisor)
        render json: { message: 'follow request sent successfully' }
    else
    render json: current_supervisor.errors.full_messages
    end
    end

    def pending
        render json: current_supervisor.pending_requests
    end
    
    def unfollow
        make_it_a_unfriend_request
        current_supervisor.unfollow(@supervisor)
        redirect_to profile_path(@supervisor)
    end

    def accept
        current_supervisor.accept_follow_request_of(@supervisor)
        make_it_a_friend_request
        redirect_to profile_path(@supervisor)
    end

    def decline
        current_supervisor.decline_follow_request_of(@supervisor)
        redirect_to profile_path(@supervisor)
    end

    def cancel
        if current_supervisor.remove_follow_request_for(@supervisor)
            render json: { message: 'follow request removed successfully' }
        else
        render json: current_supervisor.errors.full_messages
        end
    end

    private

    def make_it_a_friend_request
        current_supervisor.send_follow_request_to(@supervisor)
        @supervisor.accept_follow_request_of(current_supervisor)
    end

    def make_it_a_unfriend_request
        @supervisor.unfollow(current_supervisor) if @supervisor.mutal_following_with?(current_supervisor)
    end
    def set_supervisor
        @supervisor = Supervisor.find(params[:id])
    end

end
