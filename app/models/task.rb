class Task < ApplicationRecord
  belongs_to :supervisor
  belongs_to :agent, optional: true
end
