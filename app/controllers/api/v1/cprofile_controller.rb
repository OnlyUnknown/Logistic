# class Api::V1::CprofileController < ApplicationController
#   before_action :authenticate_customer!

#   before_action :set_user, only: %i[follow accept cancel decline unfollow]
#   def show_followers
#     render json: current_customer.followers.all
#   end

#   def follow_request
#     if current_customer
#       render json: current_customer.follow_requests
#     else
#       render json: { error: 'No user found' }, status: :unprocessable_entity
#     end
#   end

#   def pending
#     render json: current_customer.pending_requests
#   end

#   def follow
#     if current_customer.send_follow_request_to(@user)
#       render json: { message: 'follow request sent successfully' }
#     else
#       render json: current_customer.errors.full_messages
#     end
#   end

#   def unfollow
#     make_it_a_unfriend_request
#     if current_customer.unfollow(@user)
#       render json: { message: 'the user has been unfollowed successfully' }
#     else
#       render json: current_customer.errors.full_messages
#     end
#   end

#   def accept
#     if current_customer.accept_follow_request_of(@user)
#       make_it_a_friend_request
#       render json: { message: 'The follow requested has been accepted successfully' }
#     else
#       render json: current_customer.errors.full_messages
#     end
#   end

#   def decline
#     if current_customer.decline_follow_request_of(@user)
#       render json: { message: 'The follow request has been declined successfully' }
#     else
#       render json: current_customer.errors.full_messages
#     end
#   end

#   def cancel
#     if current_customer.remove_follow_request_for(@user)
#       render json: { message: 'follow request removed successfully' }
#     else
#       render json: current_customer.errors.full_messages
#     end
#   end

#   private

#   def make_it_a_friend_request
#     current_customer.send_follow_request_to(@user)
#     @user.accept_follow_request_of(current_customer)
#   end

#   def make_it_a_unfriend_request
#     @user.unfollow(current_customer) if @user.mutal_following_with?(current_customer)
#   end

#   def set_user
#     @num = first_digit(params[:id].to_i.abs)
#     @user = if @num == 1
#               Supervisor.find(params[:id])
#             elsif @num == 2
#               Agent.find(params[:id])
#             else
#               Customer.find(params[:id])
#             end
#   end

#   def first_digit(number)
#     number.to_s[0].to_i
#   end
# end
