# frozen_string_literal: true

class GetApiKey
  class << self
    def call(value)
      value ||= ''
      parts = value.split(' ')
      return parts.last if parts.length == 2 && parts.first.downcase == 'bearer'
      nil
    end
  end
end
