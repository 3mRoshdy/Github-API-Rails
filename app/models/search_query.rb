class SearchQuery
  include ActiveModel::Model
  attr_accessor :query

  validates :query, presence: true, length: {
    in: 3..30,
    message: "Keyword characters must be between 3 and 30"
  }
end