# frozen_string_literal: true

class Message < ApplicationRecord
  # ==  Elastic-Search ======================================================
  # include Elasticsearch::Model
  # include Elasticsearch::Model::Callbacks
  # settings index: { number_of_shards: 1 } do
  #   mappings do
  #     indexes :body, analyzer: 'english', index_options: 'offsets'
  #   end
  # end
  # Message.__elasticsearch__.create_index!
  # Message.import
  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Extensions ===========================================================

  # == Relationships ========================================================
  belongs_to :chat, class_name: 'Chat'
  # == Validations ==========================================================
  validates_uniqueness_of :number, scope: :chat_id
  validates :number, presence: true
  validates :body, presence: true
  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # ==  Methods =============================================================
end
