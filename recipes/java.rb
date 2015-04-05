if platform_family?('windows')
  include_recipe 'chocolatey'
  chocolatey 'javaruntime' do
    version '8.0.40'
  end
 else
  include_recipe 'java'
end
