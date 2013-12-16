module Junon
  class Client
    
    def initialize(options = {})
      @connection = Connection.establish options
      @project    = options[:project]
    end

    def jobs(project = nil)
      @connection.call_http_method(:get, 'jobs', project: project || @project).jobs
    end
   
    def run(name, options = {})
      job_id = lookup_job(name)
      params = extract_args(options)
      @connection.call_http_method(:get, "job/#{job_id}/run", params, :execution)
    end

    def lookup_job name
      jobs.detect(->{ raise "job #{name} is not defined" }){ |job| job.name == name }.id
    end
  
    def extract_args params
      exclusions = node_filter(params.delete(:exclude) || {}, true)
      inclusions = node_filter(params.delete(:include) || {})
      args       = job_args(params) unless params.empty?
      args.merge(exclusions).merge(inclusions).compact_blank      
    end
    
    def node_filter(params, inverse = false)
      params.inject({}) do |filter, (key, value)|
        key   = key.to_s.gsub(/_/, '-')
        key   = 'exclude-' + key if inverse
        value = value.join('+') if value.is_a? Array
        filter[key] = value
        filter
      end
    end

    def job_args params
      { argString: params.each_pair.map{ |key, value| "-#{key} #{value}" }.join(' ') }
    end

  end
end
