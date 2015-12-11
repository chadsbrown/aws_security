include Aws::Ec2

def whyrun_supported?
  true
end

action :associate do
  if @current_resource.exists
    Chef::Log.warn("Security Group Association #{new_resource.name} already exists - nothing to do.")
  else
    converge_by("Associating security group #{new_resource.groupname} to #{@current_resource.instanceid}") do
      ec2.modify_instance_attribute(@current_resource.instanceid, {'GroupId' => build_groups})
    end
  end
end

def load_current_resource
Chef::Log.warn("action: #{@action}")
  @current_resource =
    Chef::Resource::AwsSecurityGroupAssociation.new(@new_resource.name)

  %w(aws_access_key_id
     aws_secret_access_key
     overwrite
     instanceid
     vpcid
     groupname
     region).each do |attrib|
    @current_resource.send(attrib, @new_resource.send(attrib))
  end

  if @new_resource.aws_access_key_id || node['aws_security']['aws_access_key_id']
    @current_resource.mocking(@new_resource.mocking ||
      node['aws_security']['mocking'])
  end

  @current_resource.instanceid ||= instance_id_from_metadata
  @current_resource.vpcid ||= instance_data.vpc_id
  @current_resource.exists = true if attachment_exists?
end

def security_group
  @sg ||= ec2.security_groups.all(
            'group-name' => [@current_resource.groupname]
          ).find { |g| g.vpc_id == @current_resource.vpcid }
end

def build_groups
  @current_resource.overwrite ? [security_group.group_id] : instance_data.security_group_ids.push(security_group.group_id)
end

def attachment_exists?
  instance_data.groups.include?(@current_resource.groupname)
end

def instance_data
  @imd ||= ec2.servers.get(@current_resource.instanceid) 
end

def instance_id_from_metadata
  @iid ||= Net::HTTP.get( URI.parse( 'http://169.254.169.254/latest/meta-data/instance-id' ) )
end

def attributes
  attributes = {
    name:        @current_resource.name,
    region:      @current_resource.region
  }
  attributes[:vpc_id] = @current_resource.vpcid if @current_resource.vpcid
  attributes[:instanceid] = @current_resource.instanceid if @current_resource.instanceid
  attributes[:overwrite] = @current_resource.overwrite if @current_resource.overwrite
  attributes
end
