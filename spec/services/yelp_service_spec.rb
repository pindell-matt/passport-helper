require 'rails_helper'

describe YelpService do
  before do
    @service = Yelp.client
  end

  it "#connection" do
    VCR.use_cassette("connection-process", record: :new_episodes) do
      yelp_id = "two-rivers-coffee-arvada-2"
      expected = "Two Rivers Coffee"
      response = YelpService.connection(yelp_id).business.name
      expect(response).to eq expected
    end
  end

  it "#search" do
    VCR.use_cassette("search api", record: :new_episodes) do
      params = { term: 'Two Rivers Coffee',
        limit: 1}
        response = @service.business("two-rivers-coffee-arvada-2").business
        expect(response.name).to eq "Two Rivers Coffee"
        expect(response.id).to eq "two-rivers-coffee-arvada-2"
      end
    end
  end
