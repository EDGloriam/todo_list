class Task < ApplicationRecord
  belongs_to :project

  default_scope -> { order("position asc") }
end
