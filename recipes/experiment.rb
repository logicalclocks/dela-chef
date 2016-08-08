
script 'run_experiment' do
  cwd "/tmp"
  user node['dela-chef']['user']
  group node['dela-chef']['group']
  interpreter "bash"
  code <<-EOM

  EOM
end

