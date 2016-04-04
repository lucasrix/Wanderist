require 'rails_helper'

describe AssignGeodataService do
  let(:location) { build(:location, :valid_location) }
  let(:geo_error_msg) { I18n.t(:geocode_error, scope: [:locations, :errors]) }
  let(:geodata_success) {  double( success: true, city: Faker::Address.city) }
  let(:geodata_error) { double( success: false, city: nil) }
  subject { AssignGeodataService.new(location) }

  describe '#call' do
    before do
      allow(subject).to receive_messages(load_geodata: nil, set_geodata: nil)
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
      allow(Geokit::Geocoders::GoogleGeocoder).to receive(:reverse_geocode) { geodata_success }
      subject.send(:load_geodata)
    end

    it 'calls .reverse_geocode on Geokit::Geocoders::GoogleGeocoder' do
      expect(Geokit::Geocoders::GoogleGeocoder).to receive(:reverse_geocode)
      subject.send(:load_geodata)
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

  context 'use external API' do

    it 'can receive data from google API' do
      allow(AssignGeodataService).to receive(:call).and_call_original
      AssignGeodataService.call(location)
      expect(location.city).not_to be_nil
    end
  end
end
