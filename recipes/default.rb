version = node['formatron_filebeat']['version']

enabled = node['formatron_filebeat']['enabled']

prospectors = node['formatron_filebeat']['prospectors']
host = node['formatron_filebeat']['logstash']['host']
port = node['formatron_filebeat']['logstash']['port']

include_recipe 'formatron_beats::default'

package 'filebeat' do
  version version
end

template '/etc/filebeat/filebeat.yml' do
  variables(
    prospectors: prospectors,
    host: host,
    port: port
  )
  notifies :restart, 'service[filebeat]', :delayed if enabled
end

service 'filebeat' do
  supports status: true, restart: true, reload: false
  action [ :enable, :start ] if enabled
  action [ :disable, :stop ] unless enabled
end
