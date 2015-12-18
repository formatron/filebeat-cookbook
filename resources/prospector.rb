actions :create
default_action :create

attribute :document_type, name_attribute: true, kind_of: String, required: true
attribute :paths, kind_of: Array, required: true
