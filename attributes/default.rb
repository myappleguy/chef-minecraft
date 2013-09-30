default['minecraft']['user']                = 'mcserver'
default['minecraft']['group']               = 'mcserver'
default['minecraft']['install_dir']         = '/srv/minecraft'
default['minecraft']['base_url']            = 'https://s3.amazonaws.com/Minecraft.Download/versions'
default['minecraft']['jar']                 = 'minecraft_server'
default['minecraft']['version']             = '1.6.4'
default['minecraft']['checksum']            = 'f132f35de7202137ac86ab5b9829d191caeb286b79111cfc2b09df5789379c9b'

default['minecraft']['xms']                 = '512M'
default['minecraft']['xmx']                 = '512M'
# Additional options to be passed to java, for runit only
default['minecraft']['java-options']        = ''
default['minecraft']['init_style']          = 'mark2'

default['minecraft']['banned-ips']          = []
default['minecraft']['banned-players']      = []
default['minecraft']['white-list-users']    = []
default['minecraft']['ops']                 = []
