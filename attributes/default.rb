default['formatron_filebeat']['version'] = nil

default['formatron_filebeat']['enabled'] = true

default['formatron_filebeat']['logstash']['host'] = 'localhost'
default['formatron_filebeat']['logstash']['port'] = 5044
default['formatron_filebeat']['prospectors'] = [{
  paths: [
    '/var/log/syslog'
  ],
  document_type: 'syslog'
}]
