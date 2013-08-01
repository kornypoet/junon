module Junon
  class Job
    include Gorillib::Model
    
    field :id,      String
    field :name,    String
    field :group,   String
    field :porject, String
  end
end
