class Supervision < ApplicationRecord
  after_create :create_inverse_relationship
  after_destroy :destroy_inverse_relationship

  belongs_to :agent
  belongs_to :supervisor

  private

  def create_inverse_relationship
    supervisor.supervision.create(agent: agent)
  end

  def destroy_inverse_relationship
    supervision = supervisor.supervisions.find_by(agent: agent)
    supervision.destroy if supervision
  end
end