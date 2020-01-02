require 'spec_helper'

describe OfflineGeocoder do
  let(:bilbao_result) do
    {
      lat: 43.26271,
      lon: -2.92528,
      name: 'Bilbao',
      admin1: 'Basque Country',
      admin2: 'Bizkaia',
      cc: 'ES',
      country: 'Spain'
    }
  end

  let(:subject) { OfflineGeocoder.new }

  it 'has a version number' do
    expect(OfflineGeocoder::VERSION).not_to be nil
  end

  it 'returns correct results' do
    result = subject.search(43.26, -2.92)
    expect(result).to eq(bilbao_result)
  end

  it 'accepts strings as a parameter' do
    result = subject.search('43.26', '-2.92')
    expect(result).to eq(bilbao_result)
  end

  it 'accepts hash as a parameter' do
    result = subject.search(lat: '43.26', lon: '-2.92')
    expect(result).to eq(bilbao_result)
  end

  it 'searches by name' do
    result = subject.search(name: 'Bilbao')
    expect(result).to eq(bilbao_result)
  end

  # Not a requirement, but a test to document implemented behaviour
  it 'searches are case sensitive' do
    result = subject.search(name: 'bilbao')
    expect(result).not_to eq(bilbao_result)
  end

  it 'returns the first match' do
    result = subject.search(name: 'York', country: 'United Kingdom')
    expect(result[:country]).to eq('United Kingdom')
  end

  it 'searches by multiple attributes' do
    result = subject.search(name: 'York', country: 'United Kingdom')
    expect(result[:country]).to eq('United Kingdom')
  end
end
