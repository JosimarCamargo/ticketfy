class Ticket < ApplicationRecord
  enum status: { without_status: 0, working: 1, solved: 2 }
end
