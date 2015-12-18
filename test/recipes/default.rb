include_recipe 'formatron_filebeat::default'

formatron_filebeat_prospector 'test1' do
  document_type 'syslog'
  paths [
    '/var/log/syslog'
  ]
  notifies :restart, 'service[filebeat]', :delayed
end

formatron_filebeat_prospector 'test2' do
  document_type 'log'
  paths [
    '/var/log/*.log'
  ]
  notifies :restart, 'service[filebeat]', :delayed
end

formatron_filebeat_prospector 'test3' do
  document_type 'log'
  paths [
    '/var/log/*/*.log'
  ]
  notifies :restart, 'service[filebeat]', :delayed
end
