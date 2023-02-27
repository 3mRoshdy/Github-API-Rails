require 'rails_helper'

RSpec.describe RepositoriesController, type: :controller do
  describe "GET /search" do
    describe 'when no params are sent to request' do
      it 'should not send to github api when no params provided' do
        expect(GithubApiHelper).to_not receive(:search_repositories)
        expect(response.status).to eq(200)
        get :search

      end

      it 'should return empty response when no params provided' do
        get :search
        expect(response.status).to eq(422)
        expect(response).to_not be_successful
      end
    end

    describe 'when params are sent to search request' do
      before do
        allow(GithubApiHelper).to receive(:search_repositories).and_return({
          "total_count" => 1,
          "items" => [{
            name: 'github-repo',
            url: 'dummy-url'
          }]
        })
      end

      let(:query_params) { { query: 'adjust'} }
      let(:invalid_params) { { query: 'fo' } }

      it 'should render search layout with unprocessable_entity status' do
        get :search, params: invalid_params

        expect(response).to_not be_successful
        expect(response.status).to eq(422)
      end

      it 'should return response when params provided' do
        expect(GithubApiHelper).to receive(:search_repositories).with(query_params[:query])

        get :search, params: query_params

        expect(response).to be_successful
        expect(response.status).to eq(200)
      end
    end
  end
end
