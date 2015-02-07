actions :install, :start, :stop, :restart
default_action :install

attribute :service_name, :kind_of => String, :name_attribute => true
