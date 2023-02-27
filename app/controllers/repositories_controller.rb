class RepositoriesController < ApplicationController
  before_action :validate_search_params, only: [:search]

  def search
    response = GithubApiHelper.search_repositories(@search_query.query)

    @repos = response["items"].map do |item|
      Repository.new(item)
    end

    @total_count = response["total_count"]

    render :search, status: :ok
  end

  private

  def validate_search_params
    @search_query = SearchQuery.new(query: search_params)

    unless @search_query.valid?
      @message = @search_query.errors.full_messages_for(:query).first unless search_params.empty?
      render :search, status: :unprocessable_entity
    end
  end

  def search_params
    params.fetch(:query, '')
  end
end
