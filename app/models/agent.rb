class Agent < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self
  has_many :supervisions
  has_many :supervisors, through: :supervisions
  has_many :tasks
  has_many :supervisor_requests, foreign_key: :agent_id, dependent: :destroy
  has_many :pending_supervisors, through: :supervisor_requests, source: :supervisor
  has_many :supervisors, foreign_key: :supervisor_id, class_name: 'SupervisorRequest', dependent: :destroy
end
