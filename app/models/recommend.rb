class Recommend < ActiveRecord::Base
  acts_as_list scope: :category

  belongs_to :category
  belongs_to :entry

  validates :category, presence: true
  validates :entry, presence: true

  default_scope -> { order(:position) }

  delegate :title, to: :entry
end
