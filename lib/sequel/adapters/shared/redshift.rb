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

        # Redshift Serverless options
        # https://docs.aws.amazon.com/redshift/latest/dg/cm-c-wlm-query-monitoring-rules.html#cm-c-wlm-query-monitoring-metrics-serverless
        # TODO: Implement the rest of these, but possibly skip checking 'valid values' on some of these? Some of these values look incorrect from AWS docs (example: # Valid values are 0–86,399)

        # max_query_cpu_time
        # Query CPU time. CPU time used by the query, in seconds. CPU time is distinct from Query execution time.
        # Valid values are 0–999,999.

        # max_query_blocks_read
        # Blocks read. Number of 1 MB data blocks read by the query.
        # Valid values are 0–1,048,575.

        # max_scan_row_count
        # Scan row count. The number of rows in a scan step. The row count is the total number of rows emitted before filtering rows marked for deletion (ghost rows) and before applying user-defined query filters.
        # Valid values are 0–999,999,999,999,999.

        # max_query_execution_time
        # Query execution time. Elapsed execution time for a query, in seconds. Execution time doesn't include time spent waiting in a queue. If a query exceeds the set execution time, Amazon Redshift Serverless stops the query.
        # Valid values are 0–86,399.
        if max_query_execution_time = opts[:max_query_execution_time]
          case max_query_execution_time
          when String
            # good
          when Integer
            # good
          else
            raise Error, "unrecognized type for :max_query_execution_time. Expected type Integer or String, but instead got: #{max_query_execution_time.inspect}"
          end
          sqls << "SET max_query_execution_time = '#{max_query_execution_time}'"
        end

        # max_query_queue_time
        # Query queue time. Time spent waiting in a queue, in seconds.
        # Valid values are 0–86,399.
        if max_query_queue_time = opts[:max_query_queue_time]
          case max_query_queue_time
          when String
            # good
          when Integer
            # good
          else
            raise Error, "unrecognized type for :max_query_queue_time. Expected type Integer or String, but instead got: #{max_query_queue_time.inspect}"
          end
          sqls << "SET max_query_queue_time = '#{max_query_queue_time}'"
        end

        # max_query_cpu_usage_percent
        # CPU usage. Percent of CPU capacity used by the query.
        # Valid values are 0–6,399.

        # max_query_temp_blocks_to_disk
        # Memory to disk. Temporary disk space used to write intermediate results, in 1 MB blocks.
        # Valid values are 0–319,815,679.

        # max_join_row_count
        # Rows joined. The number of rows processed in a join step.
        # Valid values are 0–999,999,999,999,999.

        # max_nested_loop_join_row_count
        # Nested loop join row count. The number or rows in a nested loop join.
        # Valid values are 0–999,999,999,999,999.

        sqls
      end

    end
  end
end