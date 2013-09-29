#
# Cookbook Name:: minecraft
# Recipe:: mark2
#
# Copyright 2013, Greg Fitzgerald
# Copyright 2013, Sean Escriva
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

include_recipe 'python'

python_pip 'mark2'

directory '/etc/mark2' do
  owner node['minecraft']['user']
  group node['minecraft']['group']
  mode 0755
end

file '/etc/mark2/mark2.properties' do
  content '# custom settings go in server specific mark2.properties file'
  owner node['minecraft']['user']
  group node['minecraft']['group']
  mode 0644
  action :create_if_missing
end

template "#{node['minecraft']['install_dir']}/mark2.properties" do
  source 'mark2.properties.erb'
  owner node['minecraft']['user']
  group node['minecraft']['group']
  mode 0644
  notifies :reload, 'service[minecraft]', :immediately
end
