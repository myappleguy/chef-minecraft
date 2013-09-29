require 'minitest/spec'
#
## Cookbook Name:: minecraft 
## Spec:: default

describe_recipe 'minecraft::default' do
  it 'ensures minecraft is installed' do
    file("#{node['minecraft']['install_dir']}/minecraft_server.#{node['minecraft']['version']}.jar").must_exist
  end

  it 'ensures a config file is present' do
    file("#{node['minecraft']['install_dir']}/server.properties").must_exist
  end

  it 'should have proper permissions' do
    directory(node['minecraft']['install_dir']).must_exist.with(:owner, node['minecraft']['user']).and(:group, node['minecraft']['group']).and(:mode, "755")
    assert_file "#{node['minecraft']['install_dir']}/minecraft_server.#{node['minecraft']['version']}.jar", node['minecraft']['user'], node['minecraft']['group'], '644'
  end

  it 'ensures minecraft is running' do
    service('minecraft').must_be_running
  end
end
