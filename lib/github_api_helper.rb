class GithubApiHelper
  GITHUB_API_URL = "https://api.github.com"

  def self.search_repositories(search_term = '', opts = {})
    params = {
        q: search_term,
        page: opts[:page] || 1,
        per_page: opts[:size] || 50
    }
    headers = {
        'Accept' => 'application/json'
    }
    conn = Faraday.new(GITHUB_API_URL)

    resp = conn.get("search/repositories", params, headers)
    JSON.parse(resp.body) if resp&.body
  end
end