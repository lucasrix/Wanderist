require 'rails_helper'

describe AssignGeodataService do
  let(:location) { create(:location, :valid_location) }
  let(:geo_error_msg) { I18n.t(:geocode_error, scope: [:locations, :errors]) }
  let(:geodata_success) { double(success: true, city: Faker::Address.city) }
  let(:geodata_error) { double(success: false, city: nil) }
  subject { AssignGeodataService.new(location) }

  describe '#call' do
    before do
      allow(subject).to receive_messages(load_geodata: nil, set_geodata: nil)
    end

    context 'location is new record' do
      it 'returns nil' do
        location = Location.new
        result = AssignGeodataService.new(location).call
        expect(result).to be_nil
      end
    end

    it 'calls #load_geodata' do
      expect(subject).to receive(:load_geodata)
      subject.call
    end

    it 'calls #set_geodata' do
      expect(subject).to receive(:set_geodata)
      subject.call
    end
  end

  describe '#load_geodata' do
    before do
      geodata = instance_variable_get(:@geodata)
      allow(geodata).to receive(:success) { geodata_success }
    end

    context 'locatable: Profile' do
      it 'calls #get_geocode' do
        allow(subject).to receive(:geocode_service?).and_return(true)
        expect(subject).to receive(:get_geocode)
        subject.send(:load_geodata)
      end
    end

    context 'locatable: StoryPoint' do
      it 'calls #get_reverse_geocode' do
        allow(subject).to receive(:geocode_service?).and_return(false)
        expect(subject).to receive(:get_reverse_geocode)
        subject.send(:load_geodata)
      end
    end

    context 'success geo response' do
      it 'returns geodata without errors' do
        expect(location.errors.any?).to be_falsey
      end
    end

    context 'error geo response' do
      it 'returns geodata with geo error' do
        allow(Geokit::Geocoders::GoogleGeocoder).to receive(:reverse_geocode) { geodata_error }
        subject.send(:load_geodata)
        errors = location.errors[:geocode_error]
        expect(errors).to include(geo_error_msg)
      end
    end
  end

  describe '#set_geodata' do
    context 'location has validation errors' do
      it 'returns nil' do
        location.errors.add(:geocode_error, geo_error_msg)
        expect(subject.send(:set_geodata)).to be_nil
      end
    end

    context 'location doesnt have validation errors' do
      it 'returns set city in location' do
        subject.instance_variable_set :@geodata, geodata_success
        subject.send(:set_geodata)
        expect(location.city).not_to be_nil
      end
    end
  end

  describe '#get_geocode' do
    it 'calls .geocode on Geokit' do
      geokit = Geokit::Geocoders::GoogleGeocoder
      allow(geokit).to receive(:geocode)
      expect(geokit).to receive(:geocode)
      subject.send(:get_geocode)
    end
  end

  describe '#get_reverse_geocode' do
    it 'calls .reverse_geocode on Geokit' do
      geokit = Geokit::Geocoders::GoogleGeocoder
      allow(geokit).to receive(:reverse_geocode)
      expect(geokit).to receive(:reverse_geocode)
      subject.send(:get_reverse_geocode)
    end
  end

  describe '#geocode_service?' do
    it 'returns true if set Profile location' do
      subject.instance_variable_set(:@location, create(:story_point).location)
      expect(subject.send(:geocode_service?)).to be_falsey
    end
  end
end
