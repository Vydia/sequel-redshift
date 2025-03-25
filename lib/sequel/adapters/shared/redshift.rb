module Sequel
  module Redshift
    module DatabaseMethods

      def connection_configuration_sqls(opts=@opts)
        sqls = []

        # TODO: complete the full list of options:
        # https://docs.aws.amazon.com/redshift/latest/dg/cm_chap_ConfigurationRef.html

        # query_group
        # https://docs.aws.amazon.com/redshift/latest/dg/r_query_group.html
        # sql eg: set query_group to 'Monday';
        if query_group = opts[:query_group]
          case query_group
          when String
            # good
          else
            raise Error, "unrecognized type for :query_group. Expected type String, but instead got: #{query_group.inspect}"
          end
          sqls << "SET query_group = '#{query_group}'"
        end

        # search_path
        # https://docs.aws.amazon.com/redshift/latest/dg/r_search_path.html
        # sql eg: set search_path to public
        if search_path = opts[:search_path]
          case search_path
          when String
            search_path = search_path.split(",").map(&:strip)
          when Array
            # nil
          else
            raise Error, "unrecognized value for :search_path option: #{search_path.inspect}"
          end
          sqls << "SET search_path = #{search_path.map{|s| "\"#{s.gsub('"', '""')}\""}.join(',')}"
        end

        sqls
      end

    end
  end
end