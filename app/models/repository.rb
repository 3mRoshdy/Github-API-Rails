class Repository
  include ActiveModel::Model
  attr_accessor :name, :full_name, :owner_name, :html_url
  attr_accessor :description, :language, :size, :license_name

  validates :name, :full_name, :html_url, presence: true

  def initialize(attributes = {})
    attrs = attributes.with_indifferent_access

    @name  = attrs[:name]
    @full_name = attrs[:full_name]
    @owner_name = attrs.dig(:owner, :name) || 'N/A'
    @html_url = attrs[:html_url]
    @description = attrs[:description]
    @language = attrs.dig(:language) || 'N/A'
    @size = attrs[:size]
    @license_name = attrs.dig(:license, :name) || 'N/A'
  end
end