require 'rails_helper'

RSpec.describe "Repository" do
  let(:attributes) do
    {
      name: "name",
      full_name: "Full repository name",
      owner: {
        name: 'John Doe'
      },
      language: 'Ruby',
      html_url: 'dummy url',
      size: 1
    }
  end

  describe 'validations' do
    describe 'when model has invalid/missing attributes' do
      it 'should be invalid if empty attributes' do
        repository = Repository.new
        expect(repository.valid?).to be_falsy
      end
    end

    describe 'when model has valid attributes' do
      it 'should be valid if attributes are valid' do
        repository = Repository.new(attributes)

        expect(repository.valid?).to be_truthy
        expect(repository.name).to eq(attributes[:name])
        expect(repository.full_name).to eq(attributes[:full_name])
        expect(repository.owner_name).to eq(attributes[:owner][:name])
        expect(repository.language).to eq(attributes[:language])
        expect(repository.html_url).to eq(attributes[:html_url])
        expect(repository.size).to eq(attributes[:size])

        expect(repository.license_name).to eq('N/A')
      end
    end
  end
end