# Github Rails API
*Rails web application that lists out public repositories on github using a search term*

## Main components
```
- app/models
    - repository.rb
    - search_query.rb
- app/controllers
    - respositories_controller.rb
- views/
    - repositories/
        - _repository.html.erb
        - search.html.erb
- lib/
    - github_api_helper.rb
- spec/
    - controllers/
        - repositories_spec.rb
    - models/
        - repository_spec.rb
        - search_query_spec.rb
    - github_api_helper_spec.rb
```
## Models
#### SearchQuery
An `ActiveModel` class that represents the search query that will be passed to the github api as a keyword, it mainly validates on it's `query` attributes that it's present and within a certain amount of characters (min: 3, max: 30)

#### Repository
An `ActiveModel` class that represents the single repository object returned from the response og the github api `"items"`. This model helps in shaping the repository attributes along with setting defaults to any missing attributes. It also allows us to apply `collection` layout option to layout the attributes accordingly in the view

### Controller
#### RepositoriesController
Our main controller that handles the search action, it mainly consists of the `repositories#search` action that runs `validate_search_params` before running the search action to make sure that the parameters passed are valid and based on the validity it continues the action flow in a certain direction

### Libs
#### GithubApiHelper
A class containing the functionality to establish an `HTTP` connection using `Faraday` with Github's api. This class allows us to have my dynamic use with the external API along with re-using this class anywhere in our system

## Gems Used
- [**Faraday**](https://github.com/lostisland/faraday) - A flexible HTTP client library, used in the project for establishing a connection with Github's API
- [**RSpec**](https://github.com/rspec/rspec-rails) - A Gem used for faster and more clearly written test cases for modules and components in project
- [**Tailwindcss-rails**](https://github.com/rails/tailwindcss-rails) - Gem mainly for assets handling and CSS customization along with providing already built in classes to be used
## Running the application
1. Clone the project using
    ```sh
        $ git clone git@github.com:3mRoshdy/Github-API-Rails.git
    ```
2. Go to project's directory
    ```sh
        $ cd Github-API-Rails
    ```
3. Run the bash script file `./entrypoint.sh`
    ```sh
        $ sh ./entypoint.sh
    ```
    The bash script mainly:
    - Checks if the gems are installed using `bundle check` and installs them if they are not found
    - Installs `tailwind-css` dependency
    - Removed any pre-existing `server.pid` for Rails
    - Starts the Rails server

## Routes
```ruby
    Rails.application.routes.draw do
      root 'repositories#search'

      get '/search', to: 'repositories#search'
    end
```
We set the root (i.e entrypoint) of the web application to point to `repositories#search` where the `search.html.erb` will be displayed as the main layout. This layout out consists of:
1. `form_tag(...)` that executes a GET Request with passing the `query` parameter enter in the search input to the `search` action
2. Message layout to display any errors/messages passed from the server to the layout to display any notice or messages to the user entered the input
3. Repositories partial layout to render the response of github's api repositories in a form of cards, each card contains a single repository response (formatted according to the model `Repository`)

## Specs
Each model, controller and lib classes used in the project are tested in the `spec/` folder
To execute the specs simply run
```sh
    $ bundle exec rspec
```

## Gotcha's
If your facing any problem please check the following below:
1. **If you're having a connection problem with the DB** - This project was built on my macbook, so by default i had `sqlite3` installed on my device to run the rails application. I would suggest either installing `sqlite3` on your machine and run the DB **OR** Replace the database configs from `config/database.yml` to the one suitable on your machine
2. **If you're having problems with loading the Assets** - In any case if the tailwind-css assets are not complied correctly, simply try the following (rake command required)
    ```sh
        $ rake tailwindcss:build
        $ bin/dev
    ```
3. **If you're having problems with running the server from entrypoint file** - If there's any problem with running the `./entrypoint.sh` file. Simple try:
    ```sh
        $ bundle install
        $ bin/rail s
    ```

## Areas of Improvement
1. Add Logger to web server `Logger.new(STDOUT)` to improve monitoring of web application and capture logs for multiple enviroments
2. Add `Load more` functionality, since Github's api limits the number of responses return but allows pagination.
3. Add Linting gems such as `Rubocop` to format the files according and have a guideline to how files should be in case of team collaboration on the project
