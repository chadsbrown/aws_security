#
# Cookbook Name:: fake
# Recipe:: test1
#
# Author:: Greg Hellings (<greg@thesub.net>)
#
#
# Copyright 2014, B7 Interactive, LLC
#
# Licensed under the Apache License, Version 2.0 (the 'License');
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an 'AS IS' BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'aws_security::default'

#credentials = Chef::EncryptedDataBagItem.load(
#  node['aws_security']['encrypted_data_bag'],
#  'aws_keys'
#)
#
#credentials = Chef::EncryptedDataBagItem.load(
#  node['aws_security']['encrypted_data_bag'],
#  'aws_keys'
#)

credentials = node['ec2']
puts credentials

aws_security_group 'chad-test' do
  description 'chad-test-group'
  region 'us-east-1'
  aws_access_key_id credentials['aws_access_key_id']
  aws_secret_access_key credentials['aws_secret_access_key']
  action :create_if_missing
end

aws_security_group 'chad-test' do
  description 'chad-test-group'
  region 'us-east-1'
  aws_access_key_id credentials['aws_access_key_id']
  aws_secret_access_key credentials['aws_secret_access_key']
  action :create_if_missing
  vpcid 'vpc-2372e147'
end

aws_security_group 'chad-test' do
  description 'chad-test-group'
  region 'us-east-1'
  aws_access_key_id credentials['aws_access_key_id']
  aws_secret_access_key credentials['aws_secret_access_key']
  action :create_if_missing
  vpcid 'vpc-63148607'
end

aws_security_group 'test' do
  description 'test security group'
  region 'us-west-2'
  aws_access_key_id credentials['aws_access_key_id']
  aws_secret_access_key credentials['aws_secret_access_key']
end

aws_security_group 'test_source_group' do
  description 'test source security group'
  region 'us-west-2'
  aws_access_key_id credentials['aws_access_key_id']
  aws_secret_access_key credentials['aws_secret_access_key']
end

aws_security_group_rule 'test rule 1' do
  description 'test rule 1'
  cidr_ip '192.168.1.1/32'
  groupname 'test'
  region 'us-west-2'
  port_range '80..80'
  ip_protocol 'tcp'
  aws_access_key_id credentials['aws_access_key_id']
  aws_secret_access_key credentials['aws_secret_access_key']
end

aws_security_group_rule 'test rule 2' do
  cidr_ip '192.168.1.2/32'
  groupname 'test'
  region 'us-west-2'
  port_range '80..80'
  ip_protocol 'udp'
  aws_access_key_id credentials['aws_access_key_id']
  aws_secret_access_key credentials['aws_secret_access_key']
end

aws_security_group_rule 'test rule 3' do
  cidr_ip '192.168.1.3/32'
  groupname 'test'
  region 'us-west-2'
  port_range '80..80'
  ip_protocol 'tcp'
  aws_access_key_id credentials['aws_access_key_id']
  aws_secret_access_key credentials['aws_secret_access_key']
end

aws_security_group_rule 'test rule 3 (duplicate)' do
  cidr_ip '192.168.1.3/32'
  groupname 'test'
  region 'us-west-2'
  port_range '80..80'
  ip_protocol 'tcp'
  aws_access_key_id credentials['aws_access_key_id']
  aws_secret_access_key credentials['aws_secret_access_key']
end

aws_security_group_rule 'test rule 4' do
  group 'test_source_group'
  groupname 'test'
  region 'us-west-2'
  port_range '80..80'
  ip_protocol 'tcp'
  aws_access_key_id credentials['aws_access_key_id']
  aws_secret_access_key credentials['aws_secret_access_key']
end

aws_security_group_rule 'test rule 5' do
  group 'test_source_group'
  groupname 'test'
  region 'us-west-2'
  ip_protocol 'tcp'
  aws_access_key_id credentials['aws_access_key_id']
  aws_secret_access_key credentials['aws_secret_access_key']
end

#aws_security_group_rule 'test rule 5' do
#  group 'test_source_group'
#  source_group_name 'test_source_group'
#  groupname 'test'
#  region 'us-west-2'
#  ip_protocol 'tcp'
#  aws_access_key_id credentials['aws_access_key_id']
#  aws_secret_access_key credentials['aws_secret_access_key']
#end
