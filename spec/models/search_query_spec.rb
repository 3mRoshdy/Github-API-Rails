require 'rails_helper'

RSpec.describe "SearchQuery" do
  let(:invalid_query) { 'fo' }
  let(:valid_query) { 'bar' }

  describe 'validations' do
    describe 'when model has invalid attributes' do
      it 'should be invalid if empty attributes' do
        search_query = SearchQuery.new
        expect(search_query.valid?).to be_falsy
      end

      it 'should be invalid if query length not in range' do
        search_query = SearchQuery.new(query: invalid_query)
        expect(search_query.valid?).to be_falsy
      end
    end

    describe 'when model has valid attributes' do
      it 'should be valid if attributes are valid' do
        search_query = SearchQuery.new(query: valid_query)
        expect(search_query.valid?).to be_truthy
      end
    end
  end
end