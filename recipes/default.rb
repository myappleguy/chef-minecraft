#
# Cookbook Name:: minecraft
# Recipe:: default
#
# Copyright 2012, Greg Fitzgerald
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be
# included in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
# NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
# LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
# OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
# WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
#

# Only focusing on Linux and BSD suppport. Patches are welcome for OSX and Windows.

include_recipe 'java::default'

minecraft_downloads = { :linux => "https://s3.amazonaws.com/MinecraftDownload/launcher/minecraft_server.jar" }

tmpdir = Chef::Config[:file_cache_path]
minecraft_jar = "#{tmpdir}/minecraft_server.jar"
minecraft_platform = case node['os']
  when "linux"
    :linux
  else
    puts "Only supports linux right now, patches welcome."
end

if node['minecraft']['source']
  minecraft_source = node['minecraft']['source']
else
  minecraft_source = minecraft_downloads[minecraft_platform]
end

user node['minecraft']['user'] do
  system true
  shell "/bin/false"
  home node['minecraft']['install_dir']
  action :create
end

remote_file minecraft_jar do
  source minecraft_source
  owner node['minecraft']['user']
  group node['minecraft']['user']
  mode "0644"
  backup 5
end

directory node['minecraft']['install_dir'] do
  owner node['minecraft']['user']
  group node['minecraft']['user']
  mode '0755'
  action :create
  recursive true
end

execute "copy-minecraft_server.jar" do
  cwd node['minecraft']['install_dir']
  command "cp -p #{minecraft_jar} ."
  creates "#{node['minecraft']['install_dir']}/minecraft_server.jar"
end

%w[ops.txt server.properties banned-ips.txt
   banned-players.txt white-list.txt].each do |template|
  template "#{node['minecraft']['install_dir']}/#{template}" do
    source "#{template}.erb"
    owner node['minecraft']['user']
    group node['minecraft']['user']
    mode 0644
    action :create
  end
end
