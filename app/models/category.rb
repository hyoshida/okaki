class Category < ActiveRecord::Base
  has_ancestry

  acts_as_list scope: [:ancestry]

  has_many :entries

  default_scope -> { order(:position) }

  class << self
    def to_jstree(options = {})
      build_to_jstree(arrange_serializable(order: :position), options).to_json
    end

    def from_jstree!(jstree_json)
      jstree = JSON.parse(jstree_json)

      transaction do
        restore_from_jstree!(jstree)
      end
    end

    private

    def build_to_jstree(serialized_categories, options = {})
      serialized_categories.map do |serialized_category|
        options.merge(
          id: serialized_category['id'],
          text: serialized_category['name'],
          children: build_to_jstree(serialized_category['children'], options)
        )
      end
    end

    def restore_from_jstree!(jstree, parent = nil)
      return unless jstree

      jstree.each.with_index(1) do |node, index|
        next find(node['_destroy']).destroy! if node['_destroy'].present?

        restore_from_jstree_node!(node, parent, position: index)
      end
    end

    def restore_from_jstree_node!(node, parent, default_attributes = {})
      attributes = default_attributes.merge(parent: parent, name: node['text'])
      category = node['id'].to_i.zero? ? new : find(node['id'])
      category.update_attributes!(attributes)

      restore_from_jstree!(node['children'], category)
    end
  end
end
