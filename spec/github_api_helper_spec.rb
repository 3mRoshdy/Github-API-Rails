require 'rails_helper'
require 'github_api_helper'

RSpec.describe "GithubApiHelper" do
  let(:search_term) { "search/repositories" }
  let(:search_params) do
    {
      params: {
        q: 'dummy-search'
      },
      headers: {
        'Accept' => 'application/json'
      }
    }
  end

  it "should be able to search public repositories without sending search params" do
    expect_any_instance_of(Faraday::Connection).to receive(:get).with(search_term, {q: ''}, {'Accept' => 'application/json'})

    GithubApiHelper.search_repositories()
  end

  it "should be able to search public repositories with search params" do
    expect_any_instance_of(Faraday::Connection).to receive(:get).with(search_term, search_params[:params], search_params[:headers])

    GithubApiHelper.search_repositories(search_params[:params][:q])
  end

end