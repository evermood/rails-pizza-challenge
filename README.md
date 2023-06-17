
# README

<h3 align="left">Languages and Tools:</h3>
<p align="left"> <a href="https://www.docker.com/" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/docker/docker-original-wordmark.svg" alt="docker" width="40" height="40"/> </a> <a href="https://www.postgresql.org" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/postgresql/postgresql-original-wordmark.svg" alt="postgresql" width="40" height="40"/> </a> <a href="https://rubyonrails.org" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/rails/rails-original-wordmark.svg" alt="rails" width="40" height="40"/> </a> <a href="https://www.ruby-lang.org/en/" target="_blank" rel="noreferrer"> <img src="https://raw.githubusercontent.com/devicons/devicon/master/icons/ruby/ruby-original.svg" alt="ruby" width="40" height="40"/> </a> </p>

## Description

This is a application for the Evermood's code challenge a simple order view, which loads the orders from the JSON file into the database and applies configs from the config.yml file. Both files were provided by Evermood's [code challenge](https://github.com/evermood/rails-pizza-challenge). The requirements for this application is also found on Evermood's repository.
It is developed with Ruby on Rails, PostgreSQL and running on Docker.

## **Setting up**

**Requirements**:

- Docker
- Docker-compose

**Run**:

- First, change the .env.example name to .env
- Then:
```bash
    docker-compose up
    docker-compose run web rake db:create
    docker-compose run web rake db:migrate
    docker-compose run web rake db:seed
```

The application will be available on localhost:3000

## Running tests (rspec)
```bash
    docker-compose run web rspec
```

## Documentation:
- *GET /orders*  
    Lists the existing open orders

- *PATCH /order/:id*  
    Set the order as completed and redirects to the /orders

## Gems used
- Rspec
- FactoryBot
- Boostrap
- Rubocop

## Decision making
- Created orders from JSON file instead of creating all tables
I've decided to use the JSON file instead of creating all the tables and models, as it was described on the challenge to use the JSON file as basis for listing. Also, it was a decision to avoid taking a longer time.

- Able to apply only one discount code
As on the JSON file, the discount code is a string instead of Array, I took the initiative to consider only one discount code per order.

- Used rubocop as linter