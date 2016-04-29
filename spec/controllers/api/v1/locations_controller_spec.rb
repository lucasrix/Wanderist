require 'rails_helper'

describe Api::V1::LocationsController do
  include_context 'ability'

  before do
    allow(AssignGeodataService).to receive(:call).and_call_original
    create_list(:location, 3, :valid_location)
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
      reload_ability(ability)
      get :cities
      should respond_with :forbidden
    end
  end
end
