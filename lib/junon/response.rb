module Junon  
  class ResponseHandler
    
    ResponseMapping = {} unless defined? ResponseMapping

    class << self

      def register_handler(handle, klass)
        ResponseMapping[handle.to_sym] = klass
      end
      
      def retrieve_handler handle
        ResponseMapping[handle.to_sym]
      end
      
      def receive_as(result_type, attrs)
        retrieve_handler(result_type).receive attrs['result']
      end

    end
  end

  class ApiResponse
    include Gorillib::Model
    
    field :success,    :boolean
    field :error,      :boolean
    field :apiversion, Integer
    
    def self.register_handler_as handle
      ResponseHandler.register_handler(handle, self)
    end
  end
  
  class ResponseArray < Gorillib::Factory::ArrayFactory
    self.product = Array
    def response_key
      
    end
    def convert params
      puts response_key
      jobs = [params['job']].flatten.compact
      super(jobs)
    end
    register_factory!(self)
  end

  class ProjectResponse < ApiResponse
    register_handler_as :projects
    field :projects, Hash    
  end
  
  class JobResponse < ApiResponse
    register_handler_as :jobs
    field :jobs, ResponseArray, of: Job
  end

  class ExecutionResponse < ApiResponse
    register_handler_as :execution

    field :executions, ResponseArray, of: Hash
    def self.receive whatever
      whatever
    end
  end
  
end
