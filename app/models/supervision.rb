class Supervision < ApplicationRecord
  belongs_to :agent
  belongs_to :supervisor
end