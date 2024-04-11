class Supervisor < ApplicationRecord
  include Devise::JWT::RevocationStrategies::JTIMatcher
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable, :jwt_authenticatable, jwt_revocation_strategy: self

  has_many :supervisions
  has_many :agents, through: :supervisions
  has_many :tasks
  has_many :supervisor_requests, foreign_key: :supervisor_id, dependent: :destroy
  has_many :pending_agents, through: :supervisor_requests, source: :agent
  has_many :agents, through: :supervisor_requests
  has_many :supervisions, dependent: :destroy
  has_many :superviseds, through: :supervisions
end
