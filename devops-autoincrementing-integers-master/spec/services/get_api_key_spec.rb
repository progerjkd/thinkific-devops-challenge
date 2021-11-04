# frozen_string_literal: true

require 'rails_helper'

RSpec.describe GetApiKey, type: :model do
  it 'returns the API key if present as a Bearer token' do
    key = described_class.call('Bearer 123456')
    expect(key).to eq('123456')
  end

  it 'returns nil if API key is not present as a Bearer token' do
    key = described_class.call(nil)
    expect(key).to be_nil
  end
end
