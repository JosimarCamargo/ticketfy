class CreateTickets < ActiveRecord::Migration[5.2]
  def change
    create_table :tickets do |t|
      t.string :title
      t.text :content
      t.integer :status

      t.timestamps
    end
  end
end
