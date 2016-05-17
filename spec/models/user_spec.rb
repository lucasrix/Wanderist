require 'rails_helper'

RSpec.describe User, type: :model do
  it_behaves_like 'followable'
  context 'relations' do
    it { should have_one(:profile).dependent(:destroy) }
    it { should have_many(:stories) }
    it { should have_many(:story_points) }
    it { should have_many(:likes) }
    it { should have_many(:followings) }
    it { should have_many(:followers).through(:followings).source(:user) }
    it { should have_many(:gadgets) }
    it { should have_many(:notifications) }
    it { should validate_length_of(:password).is_at_least(6) }
  end

  context 'Validations' do
    subject { build(:user) }
    # it { should validate_presence_of(:username) }
    # it { should validate_uniqueness_of(:username).case_insensitive }
    context 'incorrect email format' do
      it 'returns custom error for email' do
        I18n.load_path << Rails.root.join('config', 'locales', 'en.yml')
        subject.email = Faker::Lorem.word
        subject.save
        expected_error = I18n.t(:not_email, scope: [:errors, :messages])
        errors = subject.errors[:email]
        expect(errors).to eq([expected_error])
      end
    end
  end

  context 'callbacks' do
    it 'create profile' do
      user = create(:user)
      expect(user.profile).to be_a(Profile)
    end
  end

  context 'Methods' do
    it 'return followed users' do
      user = create(:user)
      follwable_user = create(:user)
      another_users = create_list(:user, 5)
      create(:following, user: user, followable: follwable_user)
      expect(user.followed).to eq([follwable_user])
      expect(user.followed).not_to eq([another_users])
    end
  end
end
