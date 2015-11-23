version = node['formatron_filebeat']['version']
checksum = node['formatron_filebeat']['checksum']
paths = node['formatron_filebeat']['paths']
hostname = node['formatron_filebeat']['logstash']['hostname']
port = node['formatron_filebeat']['logstash']['port']
certificate = node['formatron_filebeat']['logstash']['certificate']
private_key = node['formatron_filebeat']['logstash']['private_key']

cache = Chef::Config[:file_cache_path]
deb = File.join cache, 'filebeat.deb' 
deb_url = "https://download.elastic.co/beats/filebeat/filebeat_#{version}_amd64.deb"

remote_file deb do
  source deb_url
  checksum checksum
  notifies :install, 'dpkg_package[filebeat]', :immediately
end

dpkg_package 'filebeat' do
  source deb
  action :nothing
  notifies :restart, 'service[filebeat]', :delayed
end

template '/etc/filebeat/filebeat.yml' do
  variables(
    paths: paths || [],
    hostname: hostname,
    port: port,
    certificate: certificate,
    private_key: private_key
  )
  notifies :restart, 'service[filebeat]', :delayed
end

service 'filebeat' do
  supports status: true, restart: true, reload: false
  action [ :enable, :start ]
end
