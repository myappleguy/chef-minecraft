include Chef::Mixin::ShellOut

action :start do
  minecraft_start
end

action :stop do
  action_stop
end

action :restart do
  minecraft_stop
  minecraft_start
end

 def minecraft_start
  pid = find_server_proc_id
  if pid.nil?
    converge_by("starting minecraft batch file") do
      windows_task new_resource.service_name do
        action :run
      end

      Timeout::timeout(60) do
        sleep 5 until !find_server_proc_id.nil?
      end

      new_resource.updated_by_last_action(true)
    end
  else
    Chef::Log.info("minecraft already running as pid #{pid}")
    new_resource.updated_by_last_action(false)
  end
end

def minecraft_stop
  pid = find_server_proc_id

  if !pid.nil?
    puts "stopping #{pid}"
    converge_by("Sending interrupt signal to pid #{pid}") do
      Process.kill :KILL, pid

      Timeout::timeout(60) do
        sleep 5 until find_server_proc_id.nil?
      end
    end
    new_resource.updated_by_last_action(true)
  else
    puts "nothing to stop"
    Chef::Log.info("no minecraft server to stop")
    new_resource.updated_by_last_action(false)
  end
end

def find_server_proc_id
  jar_path = ::File.join(node['minecraft']['install_dir'], minecraft_file(node['minecraft']['url']))
  Chef::Log.info("searching for process running #{jar_path}")
  wmi = ::WIN32OLE.connect("winmgmts://")
  res = wmi.ExecQuery("select ProcessId from Win32_Process where name = 'java.exe' and CommandLine like '%#{minecraft_file(node['minecraft']['url'])}%'")
  if res.each.count > 0
    res.each.next.ProcessId
  end
end