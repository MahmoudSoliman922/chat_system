# frozen_string_literal: true

class Chat < ApplicationRecord
  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Extensions ===========================================================

  # == Relationships ========================================================
  belongs_to :application, class_name: 'Application'
  # == Validations ==========================================================
  validates_uniqueness_of :number, scope: :application_id
  validates :number, presence: true
  # == Scopes ===============================================================

  # == Callbacks ============================================================

  # ==  Methods =============================================================
end
