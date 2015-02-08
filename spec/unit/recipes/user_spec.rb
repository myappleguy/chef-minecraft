require 'spec_helper'

describe 'minecraft::user' do
  context 'creates a debian user for the minecraft server' do
    let(:chef_run) do
      ChefSpec::Runner.new(:platform => 'debian', :version  => '7.0') do |node|
        node.automatic['memory']['total'] = '2097152kB'
      end.converge(described_recipe)
    end

    it 'creates a user with attributes' do
      expect(chef_run).to create_user('mcserver').with(
        shell: '/bin/false',
        gid: 'mcserver',
        home: '/srv/minecraft',
        password: nil
      )
    end
  end

  context 'creates a windows user for the minecraft server' do
    let(:chef_run) { ChefSpec::Runner.new(:platform => 'windows', :version  => '2008R2').converge('minecraft::default') }
    let(:memory) { double('win32_memory', :capacity => 2_097_152 * 1_024) }
    let(:wmi) { double('wmi', :ExecQuery => [memory]) }
    before do
      begin
        require 'win32ole'
      rescue LoadError
        class WIN32OLE
        end
      end

      allow(WIN32OLE).to receive(:connect).with('winmgmts://').and_return(wmi)
    end

    it 'creates a user with password and no group' do
      expect(chef_run).to create_user('mcserver').with(
        shell: '/bin/false',
        gid: nil,
        password: 'Pass@word1',
        home: '/minecraft'
      )
    end

    it 'renders the win api ps template' do
      expect(chef_run).to render_file("#{ENV['temp']}/LsaWrapper.ps1")
    end
  end
end
