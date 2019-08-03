# frozen_string_literal: true

class CreateChats < ActiveRecord::Migration[5.2]
  def change
    create_table :chats do |t|
      t.belongs_to :application, type: :bigint, foreign_key: true
      t.integer    :messages_count
      t.integer    :number
      t.timestamps
    end
  end
end
