class Entry < ActiveRecord::Base
  scope :recent, -> { order(:updated_at).limit(10) }
end
