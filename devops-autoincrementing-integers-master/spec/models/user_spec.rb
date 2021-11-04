# frozen_string_literal: true

require 'rails_helper'

RSpec.describe User, type: :model do
  describe 'validations' do
    subject { create(:user) }
    it { is_expected.to have_one(:integer).dependent(:destroy) }
    it { is_expected.to validate_uniqueness_of(:username).case_insensitive }
    it { is_expected.to validate_presence_of(:username) }
  end

  it 'creates an associated integer when created' do
    user = create(:user)
    expect(user.integer).not_to be_nil
  end
end
