class Task < ApplicationRecord
  belongs_to :supervisor
  belongs_to :agent, optional: true
  belongs_to :customer, optional: true
end
