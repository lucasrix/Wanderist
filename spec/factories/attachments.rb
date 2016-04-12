FactoryGirl.define do
  factory :attachment do
    file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'files', 'sample.jpg')) }
    user

    factory :video_attachment do
      file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'files', 'sample.mp4')) }
    end

    factory :audio_attachment do
      file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'files', 'sample.mp3')) }
    end
  end
end
