require 'spec_helper'

describe 'minecraft attributes' do
  cached(:chef_run) do
    ChefSpec::Runner.new(:platform => 'debian', :version  => '7.0') do |node|
      node.automatic['memory']['total'] = '2097152kB'
    end.converge('minecraft::default')
  end
  cached(:minecraft) { chef_run.node['minecraft'] }

  describe 'on an debian system' do
    it 'sets the default user & group' do
      expect(minecraft['user']).to eq('mcserver')
      expect(minecraft['group']).to eq('mcserver')
    end

    it 'sets a installation directory' do
      expect(minecraft['install_dir']).to eq('/srv/minecraft')
    end

    it 'has a base_url' do
      expect(minecraft['base_url']).to eq('https://s3.amazonaws.com/Minecraft.Download/versions')
    end

    it 'sets a jar name' do
      expect(minecraft['jar']).to eq('minecraft_server')
    end

    it 'has a version to be defined' do
      expect(minecraft['version']).to match(/\d.\d.\d/)
    end

    it 'has contains a valid checksum' do
      expect(minecraft['checksum']).to match(/\b(?:[a-fA-F0-9][\r\n]*){64}\b/)
    end

    it 'sets some default options for java' do
      expect(minecraft['xms']).to eq('819M')
      expect(minecraft['xmx']).to eq('1228M')
    end

    it 'sets java-options to be a empty string' do
      expect(minecraft['java-options']).to eq('')
    end

    it 'sets default init_style to be runit' do
      expect(minecraft['init_style']).to eq('runit')
    end

    it 'sets some empty arrays for configuration files' do
      expect(minecraft['ops']).to eq([])
      expect(minecraft['banned-ips']).to eq([])
      expect(minecraft['banned-players']).to eq([])
      expect(minecraft['white-list']).to eq([])
    end

    it 'sets autorestart to true' do
      expect(minecraft['autorestart']).to eq(true)
    end
  end
end
