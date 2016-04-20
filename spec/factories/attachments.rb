FactoryGirl.define do
  factory :attachment do
    file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'files', 'sample.jpg')) }
    user

    factory :video_mp4_attachment do
      file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'files', 'sample.mp4')) }
    end

    factory :audio_mp3_attachment do
      file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'files', 'sample.mp3')) }
    end

    factory :video_mov_attachment do
      file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'files', 'sample.mov')) }
    end

    factory :audio_m4a_attachment do
      file { Rack::Test::UploadedFile.new(File.join(Rails.root, 'spec', 'fixtures', 'files', 'sample.m4a')) }
    end
  end
end
