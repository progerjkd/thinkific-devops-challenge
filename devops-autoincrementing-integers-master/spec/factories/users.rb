# frozen_string_literal: true

FactoryBot.define do
  factory :user do
    username { 'Bob' }
    password { 'password' }
  end
end
