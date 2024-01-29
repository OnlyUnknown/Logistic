class Supervision < ApplicationRecord
    belongs_to :supervisor
    belongs_to :agent
end
