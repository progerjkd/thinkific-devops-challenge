# frozen_string_literal: true

class User < ApplicationRecord
  has_secure_password
  has_secure_token :api_key

  MIN_PASSWORD_LENGTH = 6

  has_one :integer, dependent: :destroy, class_name: 'UserInteger'

  before_create do
    build_integer
  end

  validates :username, presence: true, uniqueness: { case_sensitive: false }
  validates :password, length: { minimum: MIN_PASSWORD_LENGTH }
end
