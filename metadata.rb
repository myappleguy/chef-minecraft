maintainer       "Greg Fitzgerald"
maintainer_email "greg@gregf.org"
license          "MIT"
description      "Installs/Configures minecraft server"
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          "0.0.1"

recipe "minecraft", "Installs and configures minecraft server."

depends 'java'

%w { debian ubuntu }.each do |os|
  supports os
end
