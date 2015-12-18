def whyrun_supported?
  true
end

use_inline_resources

action :create do
  name = new_resource.name
  document_type = new_resource.document_type
  paths = new_resource.paths
  config_dir = node['formatron_filebeat']['config_dir']
  config_file = ::File.join config_dir, "prospector-#{name}.yml"
  file config_file do
    content({
      'filebeat' => {
        'prospectors' => [{
          'paths' => paths,
          'document_type' => document_type
        }]
      }
    }.to_yaml)
  end
end
