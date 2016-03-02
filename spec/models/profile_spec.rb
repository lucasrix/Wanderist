require 'rails_helper'

RSpec.describe Profile, type: :model do
  context 'constants' do
    it { expect(Profile).to have_constant(:ABOUT_MAX_LENGTH) }
  end

  context 'validations' do
    it { should validate_length_of(:about).is_at_most(Profile::ABOUT_MAX_LENGTH) }
  end

  context 'relations' do
    it { should belong_to(:user) }
  end

end
