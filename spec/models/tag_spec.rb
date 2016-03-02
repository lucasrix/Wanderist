require 'rails_helper'

RSpec.describe Tag, type: :model do
  context 'Associations' do
  end

  context 'Validations' do
    it { should validate_presence_of(:name) }
  end
end
