require 'rails_helper'

describe Api::V1::LocationsController do
  include_context 'ability'

  before do
    allow(AssignGeodataService).to receive(:call).and_call_original
    create_list(:location,  3, :valid_location)
    allow(@controller).to receive(:current_user).and_return(user)
  end

  describe 'GET #cities' do
    it 'should be success', :show_in_doc do
      get :cities
      should respond_with :ok
    end
  end

  context 'unauthorized' do
    it 'should return status 403', :show_in_doc do
      ability.cannot :cities, Location
      get :cities
      should respond_with :forbidden
    end
  end
end
