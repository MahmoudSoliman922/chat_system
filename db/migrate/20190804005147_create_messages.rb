# frozen_string_literal: true

class CreateMessages < ActiveRecord::Migration[5.2]
  def change
    create_table :messages do |t|
      t.belongs_to :chat, type: :bigint, index: true ,foreign_key: true
      t.string     :body
      t.integer    :number, index: true
      t.timestamps
    end
  end
end
