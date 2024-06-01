# frozen_string_literal: true

class Spree::Relation < ApplicationRecord
  belongs_to :relation_type
  belongs_to :relatable, polymorphic: true, touch: true
  belongs_to :related_to, polymorphic: true

  validates :relation_type, :relatable, :related_to, presence: true

  validates :discount_amount, numericality: true
  validates :discount_amount, numericality: { equal_to: 0 }, if: :bidirectional?

  after_create :create_inverse, unless: :has_inverse?, if: :bidirectional?
  after_save :update_inverse, if: :bidirectional?
  after_destroy :destroy_inverses,
    if: Proc.new { |relation| relation.bidirectional? && relation.has_inverse? }

  delegate :bidirectional?, to: :relation_type, allow_nil: true

  def has_inverse?
    self.class.exists?(inverse_options)
  end

  def inverses
    self.class.where(inverse_options)
  end

  private

  def inverse_options
    { relation_type: relation_type, relatable: related_to, related_to: relatable }
  end

  def inverse_extra_options
    { description: description }
  end

  def create_inverse
    self.class.create!(inverse_options.merge(inverse_extra_options))
  end

  def update_inverse
    inverses.update_all(inverse_extra_options)
  end

  def destroy_inverses
    inverses.each(&:destroy!)
  end
end
