# Sequel::Redshift

Amazon Redshift adapter for sequel.

## Installation

Add this line to your application's Gemfile:

    gem "sequel-redshift", git: "https://github.com/Vydia/sequel-redshift.git"

And then:

    $ bundle

## Usage

connecting to the database

    DB = Sequel.connect('redshift://#{database-url}')

    # or

    DB = Sequel.connect(
        {
            adapter: 'redshift',
            database: 'db',
            username: 'foo',
            password: 'bar',
            host: 'redshift://#{database-url}',
            port: '5439',
        },
    )

querying records

    DB[:table].where('created_at > ?', Time.now - 3600)

inserting records

    DB[:table].insert(key: value)
