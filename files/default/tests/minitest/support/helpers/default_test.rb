## Cookbook Name:: minecraft
## Helper:: default

def jar_file
  if node['minecraft']['mark2']['flavor']
    "#{node['minecraft']['install_dir']}/#{node['minecraft']['mark2']['flavor']}.jar"
  else
    "#{node['minecraft']['install_dir']}/minecraft_server.#{node['minecraft']['version']}.jar"
  end
end
