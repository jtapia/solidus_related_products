# frozen_string_literal: true

class Spree::RelationType < ApplicationRecord
  has_many :relations, dependent: :destroy

  validates :name, :applies_from, :applies_to, presence: true
  validates :name, uniqueness: { case_sensitive: false }
  validate :allowed_bidirectional, if: :bidirectional?

  attr_readonly :bidirectional

  private

  def allowed_bidirectional
    errors.add(:bidirectional, :bidirectional_not_allowed) unless applies_from == applies_to
  end
end
