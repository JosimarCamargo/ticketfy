class AddUserAssignedToTickets < ActiveRecord::Migration[5.2]
  def change
    add_reference :tickets, :user_assigned, foreign_key: { to_table: :users }
  end
end
