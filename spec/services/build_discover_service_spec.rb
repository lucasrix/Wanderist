require 'rails_helper'

describe BuildDiscoverService do
  let(:user) {create(:user)}
  subject { BuildDiscoverService.new(StoryPoint.all, Ability.new(user)) }

  let(:discover) { subject.instance_variable_get(:@discover) }

  describe '#call' do
    before do
      allow(subject).to receive_messages(load_stories: nil, delete_duplicates: nil)
    end

    after do
      subject.call
    end

    it 'calls #load_stories' do
      expect(subject).to receive(:load_stories)
    end

    it 'calls #set_geodata' do
      expect(subject).to receive(:delete_duplicates)
    end

    it 'paginates collection' do
      set_discover(build_list(:story_point, 30))
      per_page = Kaminari.config.default_per_page
      subject.call
      expect(discover.length).to eq(per_page)
    end
  end

  describe '#load_stories' do
    it 'calls #discovered on each story_point' do
      create_list(:story_point, 10)
      allow(subject).to receive(:discovered)
      expect(subject).to receive(:discovered).exactly(discover.count).times
      subject.send(:load_stories)
    end
  end

  describe '#discovered' do
    context 'story_point has stories' do
      it 'returns stories of story_point' do
        story_point = create(:story_point, :with_stories)
        stories_by_date = story_point.stories.sort_by(&:updated_at).reverse
        stories = subject.send(:discovered, story_point)
        expect(stories).to eq(stories_by_date)
      end
    end

    context 'story_point doesnt has stories' do
      it 'returns story_point' do
        story_point = create(:story_point)
        stories = subject.send(:discovered, story_point)
        expect(stories).to eq(story_point)
      end
    end
  end

  describe '#delete_duplicates' do
    it 'deletes duplicates from array' do
      story = create(:story)
      collection = Array.new (10) { story }
      set_discover(collection)
      subject.send(:delete_duplicates)
      expect(discover.length).to eq(1)
    end
  end

  def set_discover(collection)
    subject.instance_variable_set(:@discover, collection)
  end
end
