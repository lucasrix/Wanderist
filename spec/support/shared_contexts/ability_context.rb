RSpec.shared_context 'ability' do
  let(:user) { create(:user) }
  let(:ability) { Ability.new(user) }

  before do
    allow(@controller).to receive(:current_ability).and_return(ability)
  end
end
