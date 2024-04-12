class SupervisorRequest < ApplicationRecord
  belongs_to :agent
  belongs_to :supervisor

  private

  def not_friends
    errors.add(:agent, 'is already added') if supervisor.friends.include?(agent)
  end

  def not_self
    errors.add(:agent, "can't be equal to supervisor") if agent == supervisor
  end
end
