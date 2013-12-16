module Junon
  class Job
    include Gorillib::Model
    
    field :id,      String
    field :name,    String
    field :group,   String
    field :project, String
  end
end
