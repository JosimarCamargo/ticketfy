# frozen_string_literal: true

class AddUsersToTickets < ActiveRecord::Migration[5.2]
  def change
    add_reference :tickets, :requester, foreign_key: { to_table: :users }
  end
end
