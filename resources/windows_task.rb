actions :start, :stop, :restart
default_action :start

attribute :service_name, :kind_of => String, :name_attribute => true
