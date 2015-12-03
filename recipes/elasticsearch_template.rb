formatron_elasticsearch_template 'filebeat' do
  template JSON.parse(File.read('/etc/filebeat/filebeat.template.json'))
end
