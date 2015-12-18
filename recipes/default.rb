version = node['formatron_filebeat']['version']

enabled = node['formatron_filebeat']['enabled']

filebeat_etc = '/etc/filebeat'
filebeat_yml = File.join filebeat_etc, 'filebeat.yml'
config_dir = node['formatron_filebeat']['config_dir']

prospectors = node['formatron_filebeat']['prospectors']
host = node['formatron_filebeat']['logstash']['host']
port = node['formatron_filebeat']['logstash']['port']

include_recipe 'formatron_beats::default'

package 'filebeat' do
  version version
end

directory config_dir do
  recursive true
end

template filebeat_yml do
  variables(
    prospectors: prospectors,
    host: host,
    port: port,
    config_dir: config_dir
  )
  notifies :restart, 'service[filebeat]', :delayed if enabled
end

service 'filebeat' do
  supports status: true, restart: true, reload: false
  action [ :enable, :start ] if enabled
  action [ :disable, :stop ] unless enabled
end
