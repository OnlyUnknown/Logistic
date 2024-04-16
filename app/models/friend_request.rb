class FriendRequest < ApplicationRecord
  belongs_to :supervisor
  belongs_to :friend
end
