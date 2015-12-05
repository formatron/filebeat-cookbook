default['formatron_filebeat']['version'] = nil

default['formatron_filebeat']['enabled'] = true

default['formatron_filebeat']['logstash']['host'] = 'localhost'
default['formatron_filebeat']['logstash']['port'] = 5044
default['formatron_filebeat']['paths'] = ['/var/log/**/*.log']
