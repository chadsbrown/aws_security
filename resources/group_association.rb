actions :associate

default_action :associate

attribute :groupname,                :kind_of => String, :name_attribute => true, :required => true
attribute :vpcid,                    :kind_of => String, :required => false
attribute :instanceid,               :kind_of => String, :required => false
attribute :instancenames,            :kind_of => Array, :required => false
attribute :overwrite,                :kind_of => [TrueClass, FalseClass], default: false
attribute :aws_access_key_id,        :kind_of => String, :required => false
attribute :aws_secret_access_key,    :kind_of => String, :required => false
attribute :region,                   :kind_of => String, :required => true
attribute :mocking,                  kind_of: [TrueClass, FalseClass],
                                       default: false

attr_accessor :exists
