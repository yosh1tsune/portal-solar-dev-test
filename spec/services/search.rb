require 'rails_helper'

RSpec.describe Search do
  describe '.main_query' do
    it 'should return one generator matching the parameters range'\
       ' (10% of margin)' do
      matching_pg = create(:power_generator, price: 5_000, kwp: 5)
      not_matching_pg = create(:power_generator, price: 10_000, kwp: 13)

      search = Search.new(4_700, 4.7).main_query

      expect(search.length).to eq 1
      expect(search).to include matching_pg
      expect(search).not_to include not_matching_pg
    end

    it 'should return multiple generators matching the parameters range'\
       ' (10% of margin)' do
      first_matching_pg = create(:power_generator, price: 5_000, kwp: 5)
      second_matching_pg = create(:power_generator, price: 4_500, kwp: 4.8)
      third_matching_pg = create(:power_generator, price: 5_100, kwp: 5.1)
      not_matching_pg = create(:power_generator, price: 10_000, kwp: 13)

      search = Search.new(4_700, 4.7).main_query

      expect(search.length).to eq 3
      expect(search).to include first_matching_pg
      expect(search).to include second_matching_pg
      expect(search).to include third_matching_pg
      expect(search).not_to include not_matching_pg
    end

    it 'should not return any generator' do
      not_matching_pg = create(:power_generator, price: 10_000, kwp: 13)

      search = Search.new(4_700, 4.7).main_query

      expect(search.length).to eq 0
      expect(search).to eq []
      expect(search).not_to include not_matching_pg
    end
  end

  describe '.secondary_query' do
    it 'should priorize kwp and return all greater or 10% minor kwp' do
      first_matching_pg = create(:power_generator, price: 150_100, kwp: 50)
      second_matching_pg = create(:power_generator, price: 120_000, kwp: 40)
      no_match_one = create(:power_generator, price: 5_000, kwp: 7)
      no_match_two = create(:power_generator, price: 4_500, kwp: 4.8)

      search = Search.new(99_999_999, 42).secondary_query

      expect(search.length).to eq 2
      expect(search).to include first_matching_pg
      expect(search).to include second_matching_pg
      expect(search).not_to include no_match_one
      expect(search).not_to include no_match_two
    end

    it 'should return all minor or 10% greater prices if kwp is nil' do
      first_matching_pg = create(:power_generator, price: 5_200, kwp: 7)
      second_matching_pg = create(:power_generator, price: 5_000, kwp: 6.5)
      no_match_one = create(:power_generator, price: 9_000, kwp: 12)
      no_match_two = create(:power_generator, price: 5_600, kwp: 8)

      search = Search.new(5_000, nil).secondary_query

      expect(search.length).to eq 2
      expect(search).to include first_matching_pg
      expect(search).to include second_matching_pg
      expect(search).not_to include no_match_one
      expect(search).not_to include no_match_two
    end
  end
end
