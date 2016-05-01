require 'rails_helper'

RSpec.describe Gadget, type: :model do
  it { should belong_to(:user) }
  it { should validate_presence_of(:token) }
  it { should validate_length_of(:token).is_equal_to(73) }
end
