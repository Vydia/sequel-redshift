require 'sequel/adapters/postgres'
require 'sequel/adapters/shared/redshift'

module Sequel
  module Redshift
    include Postgres

    class Database < Postgres::Database
      include Sequel::Redshift::DatabaseMethods

      set_adapter_scheme :redshift

      def server_version(server=nil)
        # Example version(): PostgreSQL 8.0.2 on i686-pc-linux-gnu, compiled by GCC gcc (GCC) 3.4.2 20041017 (Red Hat 3.4.2-6.fc3), Redshift 1.0.107351
        # version_str = swallow_database_error{ds.with_sql("select version() AS v").single_value}
        # version_str = version_str.split(",").select{|s|s.downcase.include?("redshift")}.first
        # version_str = version_str.gsub(/[^0-9]/, '')
        # version_int = version_str.to_i rescue 0
        # return version_int
        return @server_version if @server_version
        return 0
      end
    end

    class Dataset < Postgres::Dataset
      Database::DatasetClass = self

      def initialize(*args)
        super(*args)
        @opts = @opts.merge(:disable_insert_returning => true).freeze
      end

      def insert_returning_sql(sql)
        sql
      end

      def supports_returning?(type)
        false
      end

      def supports_insert_select?
        false
      end
    end
  end
end