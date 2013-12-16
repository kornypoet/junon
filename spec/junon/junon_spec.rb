require 'spec_helper'

describe Junon do
  # client = Junon::Client.new('shiva').connect(token: 'u1kDSvdD5DspdPsV4D30Sn3nEPPRvNOO')
  client = Junon::Client.new(token: 'u1kDSvdD5DspdPsV4D30Sn3nEPPRvNOO', project: 'shiva')  
  puts client.jobs
  puts client.run('fire', dirname: '/Users/travis/mtg', include: { tags: ['foo'] })

  # response = c.get('job/a41885fc-66c9-4d40-a2f4-d4fcc90f08d6/run', argString: '-dirname /home/travis', tags: 'foo bar baz')
  # puts response
  # id = response['result']['executions']['execution']['id']
  # sleep 5
  # execution = c.get("execution/#{id}/output")  
  # puts execution['result']['output']['entries']['entry']

end
