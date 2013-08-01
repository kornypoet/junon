require 'spec_helper'

describe Junon do
  c = Junon::Connection.establish(token: 'u1kDSvdD5DspdPsV4D30Sn3nEPPRvNOO')
  puts c.get('projects')

end
