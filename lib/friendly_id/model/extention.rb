module FriendlyId
  module Model
    module Extention
      def to_param
        FriendlyId::Disabler.disabled? ? id.try(:to_s) : super
      end
    end
  end
end
