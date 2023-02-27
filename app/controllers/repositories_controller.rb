class RepositoriesController < ApplicationController
  def search
    # TODO: Handle defaults and empty query
    if params[:query]
      @search_query = SearchQuery.new(query: search_params)

      if @search_query.valid?
        @repos = GithubApiHelper.search_repositories(@search_query.query)["items"]
        render :search, status: :ok
      else
        @message = @search_query.errors.full_messages_for(:query).first
        render :search, status: :unprocessable_entity
      end
    end
  end

  private

  def search_params
    params.fetch(:query)
  end
end
