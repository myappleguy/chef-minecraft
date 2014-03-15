require 'spec_helper'

describe 'minecraft::default' do
  context 'install minecraft defaults' do
    cached(:chef_run) do
      ChefSpec::Runner.new(:platform => 'debian', :version  => '7.0') do |node|
        node.set['minecraft']['ops'] = %w(gregf sandal82)
        node.set['minecraft']['banned-ips'] = %w(10.1.2.3 10.1.100.10)
        node.set['minecraft']['banned-players'] = %w(gregf sandal82)
        node.set['minecraft']['white-list'] = %w(gregf sandal82)
        node.automatic['memory']['total'] = '2097152kB'
      end.converge(described_recipe)
    end
    cached(:minecraft_jar) { '/var/chef/cache/minecraft_server.1.7.5.jar' }

    it 'includes default java recipe' do
      expect(chef_run).to include_recipe('java::default')
    end

    it 'includes the minecraft::user recipe' do
      expect(chef_run).to include_recipe('minecraft::user')
    end

    it 'creates a remote_file with attributes' do
      expect(chef_run).to create_remote_file_if_missing(minecraft_jar).with(
        owner: 'mcserver',
        group: 'mcserver',
        mode: 0644
      )
    end

    it 'creates a directory for the minecraft server to live' do
      expect(chef_run).to create_directory('/srv/minecraft').with(
        user: 'mcserver',
        group: 'mcserver',
        mode: 0755,
        recursive: true
      )
    end

    it 'copies the jar file to the minecraft directory' do
      expect(chef_run).to run_execute('copy-minecraft_server.jar').with(
        cwd: '/srv/minecraft',
        command: "cp -p #{minecraft_jar} ."
      )
    end

    context 'renders the server.properties template' do
      cached(:template) { chef_run.template('/srv/minecraft/server.properties') }

      it 'renders the template' do
        expect(chef_run).to render_file(template.path).with_content('# Minecraft server properties')
      end

      it 'is owned by mcserver:mcserver' do
        expect(template.owner).to eq('mcserver')
        expect(template.group).to eq('mcserver')
      end

      it 'has 0644 permissions' do
        expect(template.mode).to eq(0644)
      end
    end

    context 'creates ops.txt' do
      cached(:ops) { chef_run.file('/srv/minecraft/ops.txt') }

      it 'creates ops.txt' do
        expect(chef_run).to create_file(ops.path).with_content("gregf\nsandal82\n")
      end

      it 'is owned by mcserver:mcserver' do
        expect(ops.owner).to eq('mcserver')
        expect(ops.group).to eq('mcserver')
      end

      it 'has 0644 permissions' do
        expect(ops.mode).to eq(0644)
      end
    end

    context 'creates banned-ips.txt' do
      cached(:banned_ips) { chef_run.file('/srv/minecraft/banned-ips.txt') }

      it 'creates banned-ips.txt' do
        expect(chef_run).to create_file(banned_ips.path).with_content("10.1.2.3\n10.1.100.10\n")
      end

      it 'is owned by mcserver:mcserver' do
        expect(banned_ips.owner).to eq('mcserver')
        expect(banned_ips.group).to eq('mcserver')
      end

      it 'has 0644 permissions' do
        expect(banned_ips.mode).to eq(0644)
      end
    end

    context 'creates banned-players.txt' do
      cached(:banned_players) { chef_run.file('/srv/minecraft/banned-players.txt') }

      it 'creates banned-ips.txt' do
        expect(chef_run).to create_file(banned_players.path).with_content("gregf\nsandal82\n")
      end

      it 'is owned by mcserver:mcserver' do
        expect(banned_players.owner).to eq('mcserver')
        expect(banned_players.group).to eq('mcserver')
      end

      it 'has 0644 permissions' do
        expect(banned_players.mode).to eq(0644)
      end
    end

    context 'creates white-list.txt' do
      cached(:white_list) { chef_run.file('/srv/minecraft/white-list.txt') }

      it 'creates banned-ips.txt' do
        expect(chef_run).to create_file(white_list.path).with_content("gregf\nsandal82\n")
      end

      it 'is owned by mcserver:mcserver' do
        expect(white_list.owner).to eq('mcserver')
        expect(white_list.group).to eq('mcserver')
      end

      it 'has 0644 permissions' do
        expect(white_list.mode).to eq(0644)
      end
    end

    it 'includes the minecraft::service recipe' do
      expect(chef_run).to include_recipe('minecraft::service')
      expect(chef_run).to include_recipe('runit')
    end
  end
end

describe 'minecraft::user' do
  context 'creates a user for the minecraft server' do
    cached(:chef_run) do
      ChefSpec::Runner.new(:platform => 'debian', :version  => '7.0') do |node|
        node.automatic['memory']['total'] = '2097152kB'
      end.converge(described_recipe)
    end

    it 'creates a user with attributes' do
      expect(chef_run).to create_user('mcserver').with(
        shell: '/bin/false',
        gid: 'mcserver',
        home: '/srv/minecraft'
      )
    end
  end
end

describe 'minecraft::service' do
  context 'starts the minecraft service' do
    cached(:chef_run) { ChefSpec::Runner.new(:platform => 'debian', :version  => '7.0').converge(described_recipe) }
    it 'enables the service' do
      # expect(chef_run).to enable_runit_service('minecraft')
      pending 'New release of the runit cookbook'
    end

    it 'starts the service' do
      # expect(chef_run).to start_runit_service('minecraft')
      pending 'New release of the runit cookbook'
    end
  end
end
