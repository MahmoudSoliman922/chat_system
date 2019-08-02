class Application < ApplicationRecord

  # == Constants ============================================================

  # == Attributes ===========================================================

  # == Extensions ===========================================================

  # == Relationships ========================================================

  # == Validations ==========================================================
  validates :application_token,
            uniqueness: true
  validates :name, presence: true
  validates :chats_count, :numericality => {:only_integer => true}, allow_nil: true
  # == Scopes ===============================================================

  # == Callbacks ============================================================
  before_create :set_access_token
  before_validation :set_defaults, on: [:create]
  # ==  Methods =============================================================
  def set_defaults
    self.chats_count ||= 0
  end

  def set_access_token
    self.application_token = generate_token
  end

  def generate_token
    loop do
      token = SecureRandom.hex(10)
      break token unless Application.where(application_token: token).exists?
    end
  end

end
