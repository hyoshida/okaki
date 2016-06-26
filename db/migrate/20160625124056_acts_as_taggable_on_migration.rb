class ActsAsTaggableOnMigration < ActiveRecord::Migration
  def change
    create_table :taggings do |t|
      t.integer :tag_id
      t.integer :taggable_id
      t.string :taggable_type
      t.integer :tagger_id
      t.string :tagger_type
      t.string :context, limit: 128
      t.datetime :created_at

      t.index [:tag_id, :taggable_id, :taggable_type, :context, :tagger_id, :tagger_type], name: :taggings_idx, unique: true
      t.index [:taggable_id, :taggable_type, :context]
    end

    create_table :tags do |t|
      t.string :name, index: { unique: true }
      t.integer :taggings_count, default: 0
    end
  end
end
