# frozen_string_literal: true

require 'rails_helper'

RSpec.describe UsersController, type: :controller do
  describe 'POST create' do
    it 'creates the new user if provided valid params' do
      expect do
        post :create, params: attributes_for(:user)
      end.to change(User, :count).by(1)
    end

    it 'is successful if provided valid params' do
      post :create, params: attributes_for(:user)
      expect(response).to be_successful
    end

    it 'does not create the new user if provided invalid params' do
      expect do
        post :create, params: { username: '', password: '' }
      end.not_to change(User, :count)
    end

    it 'is unsuccessful if provided with invalid params' do
      post :create, params: { username: '', password: '' }
      expect(response).not_to be_successful
    end

    it 'is unsuccessful if provided with a pre-existing username' do
      create(:user, username: 'Jim')
      post :create, params: { username: 'Jim', password: 'password' }
      expect(response).not_to be_successful
    end

    it 'is unsuccessful if provided with password that is too short' do
      post :create, params: { username: 'Jim', password: 'word' }
      expect(response).not_to be_successful
    end

    it 'returns the API key for the newly created user' do
      post :create, params: attributes_for(:user)
      json = JSON.parse(response.body)
      expect(json['data']['attributes']['api_key']).to eq(User.first.api_key)
    end
  end
end
