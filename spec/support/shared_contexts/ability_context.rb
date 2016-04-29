RSpec.shared_context 'ability' do
  let!(:user) { create(:user) }
  let(:ability) { Ability.new(user) }

  before do
    allow(@controller).to receive(:current_user).and_return(user)
  end

  def reload_ability(current_ability)
    allow(subject).to receive(:current_ability).and_return(current_ability)
  end
end
