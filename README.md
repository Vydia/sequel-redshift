# Sequel::Redshift

Amazon Redshift adapter for sequel.

## Installation

Add this line to your application's Gemfile:

    gem "sequel-redshift", git: "https://github.com/Vydia/sequel-redshift.git"

And then:

    $ bundle

## Usage

connecting to the database

    require "sequel/redshift"

    DB = Sequel.connect('redshift://#{database-url}')

    # or

    DB = Sequel.connect(
        {
            # Required for production
            host: 'redshift://#{database-url}',
            port: '5439',
            database: 'db',
            username: 'foo',
            password: 'bar',
            # Optional
            adapter: 'redshift',
            query_group: 'test', # See https://docs.aws.amazon.com/redshift/latest/dg/r_query_group.html
        },
    )

querying records

    DB[:table].where('created_at > ?', Time.now - 3600)

inserting records

    DB[:table].insert(key: value)
