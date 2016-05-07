module Admin
  module ApplicationHelper
    def link_to_save
      link_to '保存', 'javascript:$("form").submit()', class: 'btn btn-primary'
    end
  end
end
