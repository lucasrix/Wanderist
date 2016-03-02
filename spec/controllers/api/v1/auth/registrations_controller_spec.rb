require 'rails_helper'

describe Api::V1::Auth::RegistrationsController do
  let(:user) { create(:user) }

  before do
    @request.env["devise.mapping"] = Devise.mappings[:user]
  end

  describe "POST #create" do
    let(:params) do
      {
        'email' => Faker::Internet.email,
        'password' => Faker::Internet.password
      }
    end

    it 'should return 201' do
      post :create, params
      should respond_with :created
    end

    it 'should create a new user' do
      expect { post :create, params }.to change { User.count }.by(1)
    end

    it 'should create profile with given params', :show_in_doc do
      first_name = Faker::Name.first_name
      last_name = Faker::Name.last_name
      params.merge!({
        'first_name' => first_name,
        'last_name' => last_name,
        'photo' => fixture_file_upload('files/sample.jpg', 'image/jpeg')
      })

      post :create, params

      profile = Profile.last
      expect(profile.first_name).to eq first_name
      expect(profile.last_name).to eq last_name
      expect(profile.photo_url).not_to be_empty
    end

    context 'email already in use' do
      it 'returns 403', :show_in_doc do
        params['password'] = nil
        create(:user, email: params['email'])

        post :create, params
        should respond_with :forbidden
      end
    end
  end

end