gzip_test = input('gzip_test', value: '/bin/gzip -kv /hab/svc/gzip/hooks/run')

describe bash(gzip_test) do
  its('stdout') { should match replaced }
  its('exit_status') { should eq 0 }
end

describe file('/hab/svc/gzip/hooks/run.gz') do
  it { should exist }
end
