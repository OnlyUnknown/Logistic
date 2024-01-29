class Supervisor < ApplicationRecord
    has_many :supervisions
    has_many :agents, through: :supervisions
end
