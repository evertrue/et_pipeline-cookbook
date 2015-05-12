#
# Cookbook Name:: et_pipeline
# Recipe:: default
#

include_recipe 'apt' if node.platform_family == 'debian'

include_recipe 'pipeline::jenkins'
include_recipe 'pipeline::chefdk'
include_recipe 'chef-zero'
include_recipe 'pipeline::knife'
include_recipe 'pipeline::jobs'

ssh_known_hosts_entry 'github.com'

directory "#{node['jenkins']['master']['home']}/.ssh" do
  mode   0700
  owner  node['jenkins']['master']['user']
  group  node['jenkins']['master']['group']
  action :create
end

file "#{node['jenkins']['master']['home']}/.ssh/id_rsa" do
  mode    0600
  owner   node['jenkins']['master']['user']
  group   node['jenkins']['master']['group']
  content data_bag_item('secrets', 'deploy_keys')['jenkins']
end

directory '/root/.ssh' do
  mode 0700
end

# Populating a deploy key for root feels wrong but I'm not quite sure what to do
# instead.
file '/root/.ssh/id_rsa' do
  mode 0600
  content data_bag_item('secrets', 'deploy_keys')['jenkins']
end
