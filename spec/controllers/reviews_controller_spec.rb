require 'rails_helper'

describe ReviewsController do
  describe 'POST create' do
    it 'reviews the data' do
      # create clone the repo
      # pull the code
      # run pronto
      post :create
      expect(response).to be_success
    end
  end
end
