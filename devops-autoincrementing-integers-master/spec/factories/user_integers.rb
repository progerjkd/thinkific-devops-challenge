# frozen_string_literal: true

FactoryBot.define do
  factory :user_integer do
    value { 1 }
    association :user, factory: :user
  end
end
