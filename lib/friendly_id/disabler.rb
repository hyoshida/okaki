# from https://github.com/norman/friendly_id/issues/691
module FriendlyId
  # This module is used to conditionally enable friendly_id #to_param since it may cause issues when
  # friendly id is used with :scope and other frameworks that rely on `link_to`
  module Disabler
    # Used as key in `Thread.current` hash, if not set this module does nothing
    THREAD_LOCAL_KEY = :__friendly_id_enabler_disabled

    class << self
      # Return true iff friendly_id is currently disabled
      def disabled?
        !!Thread.current[THREAD_LOCAL_KEY]
      end

      # Run a block with friendly id disabled
      def disable_friendly_id(&block)
        begin
          old_value, Thread.current[THREAD_LOCAL_KEY] = Thread.current[THREAD_LOCAL_KEY], true
          block.call
        ensure
          Thread.current[THREAD_LOCAL_KEY] = old_value
        end
      end
    end
  end
end
