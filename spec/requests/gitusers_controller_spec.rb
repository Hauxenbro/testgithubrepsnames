# frozen_string_literal: true

require 'rails_helper'

RSpec.describe 'GitusersControllers', type: :request do
  describe 'GET /index' do
    before(:each) do
      get gitusers_path
    end

    it 'Response - 200 status code' do
      expect(response.status).to eq(200)
    end
    it 'Render #index template' do
      expect(response).to render_template(:index)
    end
  end

  describe 'POST :create' do
    it 'Redirects to index or to show' do
      post gitusers_path, params: { gituser: { log: 'Hauxenbro' } }
      expect(response.status).to eq 302
    end
  end

  describe 'GET :show' do
    before(:each) do
      @gituser = Gituser.first
    end

    it 'Get :Show teturn 200 status code for exact user' do
      get gitusers_path(38)
      expect(response.status).to eq 200
    end
  end
end
