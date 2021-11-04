# frozen_string_literal: true

class SerializableUserInteger < JSONAPI::Serializable::Resource
  type 'user_integer'
  attributes :value
end
