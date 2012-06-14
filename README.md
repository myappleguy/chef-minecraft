#Minecraft [![Build Status](https://secure.travis-ci.org/gregf/cookbook-minecraft.png)](http://travis-ci.org/gregf/cookbook-minecraft)

##Description

Installs vanilla [Minecraft](http://www.minecraft.net) server.

##Requirements

Requires the [java](https://github.com/opscode-cookbooks/java) cookbook which is defined in the recipe.

###Platform

* Debian, Ubuntu

##Attributes

See `attributes/default.rb` for default values.

* `default['minecraft']['user']`
* `default['minecraft']['install_dir']`

* `default['minecraft']['banned-ips']`
* `default['minecraft']['banned-players']`
* `default['minecraft']['white-list-users']`
* `default['minecraft']['ops']`

* `default['minecraft']['allow-nether']`
* `default['minecraft']['level-name']`
* `default['minecraft']['enable-query']`
* `default['minecraft']['allow-flight']`
* `default['minecraft']['server-port']`
* `default['minecraft']['level-type']`
* `default['minecraft']['enable_rcon']`
* `default['minecraft']['level-seed']`
* `default['minecraft']['server-ip']`
* `default['minecraft']['max-build-height']`
* `default['minecraft']['spawn-npcs']`
* `default['minecraft']['white-list']`
* `default['minecraft']['spawn-animals'] `
* `default['minecraft']['online-mode']`
* `default['minecraft']['pvp']`
* `default['minecraft']['difficulty']`
* `default['minecraft']['gamemode']`
* `default['minecraft']['max-players']`
* `default['minecraft']['spawn-monsters']`
* `default['minecraft']['generate-structures']`
* `default['minecraft']['view-distance']`
* `default['minecraft']['motd']`

##Usage

Include the `minecraft` recipe and modify your run list and set any attributes
you would like changed.

    run_list [
      "recipe[minecraft]"
    ]
    "minecraft":{
      "motd": "Welcome all griefers!"
      "max-players": 9001
      "ops": ["nappa", "goku"]
    }


##Recipes

###default

Include the default recipe into your run_list to install `minecraft` server.
Configuration files are prepopulated based on values in attributes. I will keep
the defaults in sync with upstream.

##TODO

* Proper init scripts (currently missing)
* More attributes
  - min/max ram
  - group
  - custom download url, no one at mojang knows what a version number is..
  - checksums?
* Support more distros & BSD
* Plugin support once 1.3 is released?

##License

Copyright 2012, Greg Fitzgerald
Permission is hereby granted, free of charge, to any person obtaining
a copy of this software and associated documentation files (the
"Software"), to deal in the Software without restriction, including
without limitation the rights to use, copy, modify, merge, publish,
distribute, sublicense, and/or sell copies of the Software, and to
the following conditions:
permit persons to whom the Software is furnished to do so, subject to

The above copyright notice and this permission notice shall be
included in all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE
LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION
OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION
WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

