# frozen_string_literal: true

class UserInteger < ApplicationRecord
  belongs_to :user

  validates :user, presence: true
  validates :value, presence: true, numericality: { only_integer: true, greater_than: 0 }

  def change(args)
    args.symbolize_keys!
    apply_change(args)
  end

  private

  def apply_change(args)
    action = args[:action]
    case action
    when :increment
      by = (args[:by] || 1).to_i
      increment_value(by) if ensure_not_negative(by)
    when :update
      to = args[:to].to_i
      update_value(to) if ensure_not_negative(to)
    end
  end

  def increment_value(by_value)
    transaction do
      current = value
      update_value(current + by_value)
    end
  end

  def update_value(new_value)
    update(value: new_value)
  end

  def ensure_not_negative(value)
    errors[:base] << 'cannot provide a negative or zero value' if value < 1
    errors.empty?
  end
end
