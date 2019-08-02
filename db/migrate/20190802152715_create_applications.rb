class CreateApplications < ActiveRecord::Migration[5.2]
  def change
    create_table :applications do |t|
      t.string     :application_token, index: true, unique: true
      t.string     :name
      t.integer    :chats_count
      t.timestamps
    end
  end
end
