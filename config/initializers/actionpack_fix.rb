module ActionDispatch
  class Request
    class Session
      def []=(key, value)
        @delegate[key.to_s] = value
      end
    end
  end
end
