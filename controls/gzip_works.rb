gzip = input("gzip", value: "/bin/gzip")
plan_origin = ENV["HAB_ORIGIN"]
plan_name = input("plan_name", value: "gzip")
plan_ident = "#{plan_origin}/#{plan_name}"
hook_path = input("hook_path", value: "hooks/run")

hab_pkg_path = command("hab pkg path #{plan_ident}")
describe hab_pkg_path do
  its("exit_status") { should eq 0 }
  its("stdout") { should_not be_empty }
end

run_hook = File.join(hab_pkg_path.stdout.strip, hook_path)

#gzip verbose messages get sent to stderr so it is piped to stdout
describe bash("#{gzip} -kv #{run_hook} 2>&1") do
  its("exit_status") { should eq 0 }
  its("stdout") { should match /created/ } 
end

describe file("#{run_hook}.gz") do
  it { should exist }
end
