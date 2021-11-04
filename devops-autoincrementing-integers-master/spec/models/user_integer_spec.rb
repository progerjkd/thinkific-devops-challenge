# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UserInteger, type: :model do
  it { is_expected.to belong_to(:user) }
  it { is_expected.to validate_numericality_of(:value).only_integer.is_greater_than(0) }
  it { is_expected.to validate_presence_of(:value) }

  describe '#change' do
    subject { create(:user_integer) }

    context 'action: :increment' do
      it 'increments by 1 by default' do
        expect { subject.change(action: :increment) }.to change(subject, :value).by(1)
      end

      it 'increments by amount specified' do
        expect { subject.change(action: :increment, by: 5) }.to change(subject, :value).by(5)
      end

      it 'is returns false if the amount provided is less than 1' do
        expect(subject.change(action: :increment, by: -5)).to be_falsey
      end

      it 'has an error message if the amount provided is less than 1' do
        subject.change(action: :increment, by: -5)
        expect(subject.errors[:base]).not_to be_empty
      end
    end

    context 'action: :update' do
      it 'changes to the amount specified' do
        subject.change(action: :update, to: 5)
        expect(subject.value).to eq(5)
      end

      it 'returns false if the amount provided is less than 1' do
        expect(subject.change(action: :update, to: -5)).to be_falsey
      end

      it 'has an error message if the amount provided is less than 1' do
        subject.change(action: :update, to: -5)
        expect(subject.errors[:base]).not_to be_empty
      end
    end
  end
end
