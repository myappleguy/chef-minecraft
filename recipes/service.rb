#
# Cookbook Name:: minecraft
# Recipe:: service
#
# Copyright 2012, Greg Fitzgerald
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



case node['minecraft']['init_style']
when "runit"
  include_recipe 'runit'

  runit_service "minecraft"

  service 'minecraft' do
    supports :status => true, :restart => true, :reload => true
    reload_command "#{node['runit']['sv_bin']} hup #{node['runit']['service_dir']}/minecraft"
    action [:enable, :start]
  end
when "mark2"
  service 'minecraft' do
    pattern "python /usr/local/bin/mark2"
    start_command "sudo -u #{node['minecraft']['user']} mark2 start #{node['minecraft']['install_dir']}"
    stop_command "sudo -u #{node['minecraft']['user']} mark2 stop #{node['minecraft']['install_dir']}"
    restart_command "sudo -u #{node['minecraft']['user']} mark2 send ~restart"
    reload_command "sudo -u #{node['minecraft']['user']} mark2 send ~reload"
    supports :restart => true, :reload => true, :status => false
    action [:start]
   end
end
