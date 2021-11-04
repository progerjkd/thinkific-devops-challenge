# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::UserIntegersController, type: :controller do
  def request_map
    { show: :get, increment: :put, update: :put }
  end

  context 'with no API key' do
    describe 'any access attempt' do
      it 'is unauthorized' do
        request_map.each do |action, method|
          send(method, action)
          expect(response).to be_unauthorized
        end
      end
    end
  end

  context 'with non-existant API key' do
    before do
      request.headers['Authorization'] = 'Bearer 123456'
    end

    describe 'any access attempt' do
      it 'is unauthorized' do
        request_map.each do |action, method|
          send(method, action)
          expect(response).to be_unauthorized
        end
      end
    end
  end

  context 'with valid API key' do
    let!(:user) { create(:user) }

    before do
      request.headers['Authorization'] = "Bearer #{user.api_key}"
    end

    def expect_integer_value_to_match(value)
      json = JSON.parse(response.body)
      expect(json['data']['attributes']['value']).to eq(value)
    end

    describe 'GET show' do
      it 'returns the current integer for the user' do
        get :show
        expect_integer_value_to_match(User.first.integer.value)
      end

      it 'is successful' do
        get :show
        expect(response).to be_successful
      end
    end

    describe 'PUT increment' do
      it 'increments the current integer value by 1' do
        current = User.first.integer.value
        put :increment
        expect(User.first.integer.value).to eq(current + 1)
      end

      it 'is successful' do
        put :increment
        expect(response).to be_successful
      end

      it 'returns the new integer' do
        put :increment
        expect_integer_value_to_match(User.first.integer.value)
      end
    end

    describe 'PUT update' do
      it 'changes the current integer value to the value specified' do
        put :update, params: { value: 10 }
        expect(User.first.integer.value).to eq(10)
      end

      it 'is successful' do
        put :update, params: { value: 10 }
        expect(response).to be_successful
      end

      it 'returns the new integer' do
        put :update, params: { value: 10 }
        expect_integer_value_to_match(User.first.integer.value)
      end

      it 'is unsuccessful if provided a value of less than 1' do
        put :update, params: { value: 0 }
        expect(response).not_to be_successful
      end

      it 'does not change the current value if provided a value of less than 1' do
        current = User.first.integer.value
        put :update, params: { value: 0 }
        expect(current).to eq(User.first.integer.value)
      end
    end
  end
end
