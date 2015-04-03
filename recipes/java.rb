if platform_family?('windows')
  include_recipe 'chocolatey'
  chocolatey 'javaruntime'
else
  include_recipe 'java'
end
