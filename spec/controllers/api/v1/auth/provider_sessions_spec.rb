require 'rails_helper'

describe Api::V1::Auth::ProviderSessionsController do
  describe "POST #create" do
    it 'should return 200' do
      post :create, facebook_access_token: 'CAACEdEose0cBAOPBxcBBjFxdVZCEC4Ngv6rR4LBY9blqHLH3JxM9XlLwVHg2q1gLL5pFr5ti5j8UcD9ZCqDgIm4i5vO4dt1sdI8ShleWB0UHEaWCh3wtBDvhoCzDNZBdXAUk0l1NcO6lJemr9XWs8cH72zrKbTzPKDzDx004nmImbsJ1zxERUz9QIzDifiumftkswmRm2QZDZD'
      expect(response).to be_success
    end

    it 'should return 404', :show_in_doc do
      post :create, facebook_access_token: 'wrong access token'
      expect(response).to be_not_found
    end
  end
end