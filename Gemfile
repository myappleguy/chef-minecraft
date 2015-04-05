source 'https://rubygems.org'

group :lint do
  gem 'foodcritic', '~> 3.0'
  gem 'rubocop', '~> 0.18'
  gem 'rainbow', '< 2.0'
end

group :unit do
  gem 'berkshelf', '~> 3.1.5'
  gem 'chefspec', '~> 4.0'
end

group :kitchen_common do
  gem 'winrm-transport'
  gem 'test-kitchen', '1.4.0.rc.1'
end

group :kitchen_vagrant do
  gem 'kitchen-vagrant', "0.17.0.rc.1"
  gem 'vagrant-wrapper'
end

group :kitchen_cloud do
  gem 'kitchen-digitalocean'
end

group :development do
  gem 'rake'
  gem 'stove', '~> 3.2.2'
end
