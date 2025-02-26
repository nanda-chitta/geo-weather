# Weather forecaster app with Ruby on Rails

## Scope

1. Using Ruby On Rails.

2. Accept an address as input.

3. Retrieve forecast data for the given address. This should include, at minimum, the current temperature. Bonus points: retrieve high/low and/or extended forecast.

4. Display the requested forecast details to the user.

5. Cache the forecast details for 30 minutes for all subsequent requests by zip codes. Display indicator in result is pulled from cache.


## Set up Ruby and Rails

This app is developed on a MacBook Pro M1 with macOS Sequoia.

### Install node using nvm

```sh
$ cd ~
$ touch .zshrc
$ curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.1/install.sh | bash
$ export NVM_DIR="$HOME/.nvm"
   [ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"  # This loads nvm
   [ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"  # This loads nvm bash_completion
$ source ~/.zshrc   
```
Install LTS version of Node

```sh
$ nvm install --lts
$ nvm use --lts
$ nvm alias default v20.18.3
```

### Install RVM

The `rvm` ruby version manager to install `ruby` and `ruby-ralities`.

Install `rvm` ruby version manager via `brew`:

```sh
$ brew install gnupg
$ gpg --keyserver keyserver.ubuntu.com --recv-keys 409B6B1796C275462A1703113804BB82D39DC0E3 7D2BAF1CF37B13E2069D6956105BD0E739499BDB
$ \curl -sSL https://get.rvm.io | bash
```
We will receive a thank you 🙏 message in the console. 

Quit all Terminal.

Lunch a new Terminal and try

### Verify RVM

```sh
$ rvm --version
$ rvm list
```
We will get this message

```sh
# No rvm rubies installed yet. Try 'rvm help install'.
```
Install some ruby version such as 2.7.7

```sh
$ rvm install 2.7.1
```
After installation, check which ruby version available.

```sh
$ rvm list
ruby-2.7.7 [ x86_64 ]
# Default ruby not set. Try 'rvm alias create default <ruby>'.
```

Create default ruby version

```sh
$ rvm alias create default 2.7.1
```
### Clone the repo

```sh

$ git clone git@github.com:nanda-chitta/geo-weather.git
$ cd geo-weather
$ git checkout master
$ gem install bundler
$ bundle install
$ cd frontend/weather-forecast
$ npm install
$ cd -
$ bundle exec rails db:create # creates the database
$ bundle exec rails db:migrate # create the schema in the database

```
### Run the server

```sh
$ foreman start
# open http://localhost:3000/ in your browser and see the weather forecast app. 
$ bundle exec rspec # runs rspec unit tests
```
