git_path = input('gzip_path', value: '/bin/gzip')

describe file(gzip_path) do
  it { should exist }
end
