require 'rails_helper'

RSpec.describe PushNotificationJob, type: :job do
  let(:tokens) { Array.new(10) { rand(1...9) } }
  let(:message) { Faker::Lorem.sentence }
  let(:link) { Faker::Lorem.sentence }

  it 'sends push to APN connection' do
    allow(APN).to receive(:push)
    expect(APN).to receive(:push).exactly(tokens.length).times
    PushNotificationJob.perform_now(tokens, message, link)
  end
end
