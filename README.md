# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions

* ...



* Update and upgrade system :
    * <code>sudo apt update</code>
    * <code>sudo apt upgrade</code>

* Install libraries:
    * <code>sudo apt install curl</code>
    * <code>curl -sL https://deb.nodesource.com/setup_lts.x | sudo -E bash -</code>
    * <code>curl -sS https://dl.yarnpkg.com/debian/pubkey.gpg | sudo apt-key add -</code>
    * <code>echo "deb https://dl.yarnpkg.com/debian/ stable main" | sudo tee /etc/apt/sources.list.d/yarn.list</code>
    * <code>sudo apt-get update</code>
    * <code>sudo apt-get install git-core zlib1g-dev build-essential libssl-dev libreadline-dev libyaml-dev libsqlite3-dev sqlite3 libxml2-dev libxslt1-dev libcurl4-openssl-dev software-properties-common libffi-dev nodejs yarn</code>

* Install Rbenv :
    * <code>cd</code>
    * <code>git clone https://github.com/rbenv/rbenv.git ~/.rbenv</code>
    * <code>echo 'export PATH="$HOME/.rbenv/bin:$PATH"' >> ~/.bashrc</code>
    * <code>echo 'eval "$(rbenv init -)"' >> ~/.bashrc</code>
    * <code>exec $SHELL</code>

* Install Ruby :
    * <code>git clone https://github.com/rbenv/ruby-build.git ~/.rbenv/plugins/ruby-build</code>
    * <code>echo 'export PATH="$HOME/.rbenv/plugins/ruby-build/bin:$PATH"' >> ~/.bashrc</code>
    * <code>exec $SHELL</code>
    * <code>rbenv install <em>last-ruby-version</em></code>
    * <code>rbenv global <em>last-ruby-version</em></code>
    * <code>ruby -v</code>

* Install Bundler :
    * <code>gem install bundler</code>

* Install Rails :
    * <code>gem install rails -v <em>last-rails-version</em></code>
    * <code>rbenv rehash</code>
    * <code>rails -v</code>

* Install PostgreSQL :
    * <code>sudo apt install postgresql-11 libpq-dev</code>
    * <code>sudo -u postgres createuser <em>YOUR-LOGIN</em> -s</code>
    * <code>sudo -u postgres psql</code>
    * <code>postgres=<em>password</em></code>

* Clone project : 
    * <code>git clone https://github.com/SalimBXL/Orga.git</code>
    * <code>cd Orga</code>

    * Check ruby version :
        * <code>cat ./.ruby-version</code>
        * <code>rbenv install <em>ruby-version</em></code>

    * Install project dependencies : 
        * <code>bundle install</code>

    * Create database :
        * <code>rails db:create</code>
        * <code>rails db:migrate</code>


    
