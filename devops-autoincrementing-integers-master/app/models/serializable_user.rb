# frozen_string_literal: true

class SerializableUser < JSONAPI::Serializable::Resource
  type 'user'
  attributes :api_key
end
