class CreateReminders < ActiveRecord::Migration[5.2]
  def change
    create_table :reminders do |t|
      t.integer :user_id
      t.string :relation
      t.string :birthday
      t.string :person_name
      t.boolean :send_reminder
      t.string :phone
      t.string :notes

      t.timestamps
    end
  end
end
