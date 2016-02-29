require 'rails_helper'

describe ProviderAuthService do
  subject { ProviderAuthService.new }

  describe '.facebook_auth' do
    let(:koala) { double }
    let(:token) { Faker::Lorem.characters(212) }
    let(:me) do
      {
        "id" => Faker::Number.number(15),
        "email" => Faker::Internet.email,
        "first_name" => Faker::Name.first_name,
        "gender" => %w(male female).sample,
        "last_name" => Faker::Name.last_name,
        "link" => "https://www.facebook.com/app_scoped_user_id/100001557261231/",
        "locale" => "ru_RU",
        "name" => Faker::Name.name,
        "timezone" => 2,
        "updated_time" => "2015-06-07T02:05:59+0000",
        "verified" => true
      }
    end

    before do
      allow(koala).to receive(:get_object).with('me').and_return(me)
      allow(Koala::Facebook::API).to receive(:new).with(token).once.and_return(koala)
    end

    it 'creates Koala::Facebook::API with access token' do
      expect(Koala::Facebook::API).to receive(:new).with(token).once.and_return(koala)
      ProviderAuthService::facebook_auth(token)
    end

    it 'returns existing user' do
      user = create(:user, uid: me["id"], provider: 'facebook')
      expect(ProviderAuthService::facebook_auth(token)).to eq user
    end

    it 'creates a new user' do
      expect { ProviderAuthService::facebook_auth(token) }.to change { User.count }.by(1)
    end
  end

end