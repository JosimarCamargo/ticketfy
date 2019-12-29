class CreateReplies < ActiveRecord::Migration[5.2]
  def change
    create_table :replies do |t|
      t.references :ticket, foreign_key: true
      t.text :content
      t.references :user, foreign_key: true

      t.timestamps
    end
  end
end
