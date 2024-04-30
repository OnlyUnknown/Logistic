class Supervisor < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self
  followability

  has_many :supervisions
  has_many :agents, through: :supervisions
  has_many :tasks

  def unfollow(_supervisor)
    followerable_relationships.where(followable_id: user.id).destroy_all
  end
end
