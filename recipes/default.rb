version = node['formatron_filebeat']['version']

paths = node['formatron_filebeat']['paths']
host = node['formatron_filebeat']['logstash']['host']
port = node['formatron_filebeat']['logstash']['port']

include_recipe 'formatron_beats::default'

package 'filebeat' do
  version version
end

template '/etc/filebeat/filebeat.yml' do
  variables(
    paths: paths,
    host: host,
    port: port
  )
  notifies :restart, 'service[filebeat]', :delayed
end

service 'filebeat' do
  supports status: true, restart: true, reload: false
  action [ :enable, :start ]
end
