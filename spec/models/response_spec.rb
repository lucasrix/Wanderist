require 'rails_helper'

RSpec.describe Response, type: :model do
  subject { Response.new }

  describe '#success?' do
    it 'returns true' do
      expect(subject).to be_success
    end

    context 'has errors' do
      it 'returns false' do
        subject.instance_variable_set(:@error_messages, [Faker::Hipster.paragraph])
        expect(subject).not_to be_success
      end

      it 'returns false' do
        subject.instance_variable_set(:@details, { email: Faker::Hipster.paragraph })
        expect(subject).not_to be_success
      end

      it 'returns false' do
        subject.instance_variable_set(:@error_messages, [Faker::Hipster.paragraph])
        subject.instance_variable_set(:@details, { email: Faker::Hipster.paragraph })
        expect(subject).not_to be_success
      end
    end
  end

  describe '#add_error_message' do
    it 'adds given message to @error_messages' do
      msg = Faker::Hipster.sentence
      subject.add_error_message(msg)
      expect(subject.instance_variable_get(:@error_messages)).to include(msg)
    end
  end

  describe '#status' do
    it 'returns success' do
      allow(subject).to receive(:success?).and_return(true)
      expect(subject.status).to eq 'success'
    end

    it 'returns error' do
      allow(subject).to receive(:success?).and_return(false)
      expect(subject.status).to eq 'error'
    end
  end

  describe '#error' do
    it 'returns Hash' do
      expect(subject.error).to be_a(Hash)
    end

    it 'contains error_messages' do
      subject.instance_variable_set(:@error_messages, [Faker::Hipster.paragraph])
      expect(subject.error).to have_key('error_messages')
    end

    it 'contains details' do
      subject.instance_variable_set(:@details, Faker::Hipster.paragraph)
      expect(subject.error).to have_key('details')
    end
  end

  describe '#prepare' do
    let(:data) { create(:story_point) }

    it 'calls #set_data_serializer' do
      expect(subject).to receive(:set_data_serializer).once.with(data).and_call_original
      subject.prepare(data)
    end

    it 'calls #set_errors' do
      expect(subject).to receive(:set_errors).once.with(data).and_call_original
      subject.prepare(data)
    end

    it 'gets serializer for empty collection' do
      expect_any_instance_of(String).to receive(:constantize).and_call_original
      subject.prepare(Story.none)
    end
  end

  describe '#attributes' do
    it 'returns Hash' do
      expect(subject.attributes).to be_a(Hash)
    end

    it 'contains status' do
      expect(subject.attributes).to have_key('status')
    end

    it 'contains data' do
      expect(subject.attributes).to have_key('data')
    end

    it 'contains error' do
      expect(subject.attributes).to have_key('error')
    end

  end

  describe '#initialize' do
    it 'initialize @error_messages' do
      expect(subject.instance_variable_get(:@error_messages)).to be_a(Array)
    end

    it 'initialize @details' do
      expect(subject.instance_variable_get(:@details)).to be_a(Hash)
    end

    it 'calls prepare' do
      story_point = build(:story_point)
      expect_any_instance_of(Response).to receive(:prepare).once.with(story_point)
      Response.new(story_point)
    end
  end

end