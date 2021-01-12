#
# Cookbook:: apache
# Recipe:: server
#
# Copyright:: 2021, The Authors, All Rights Reserved.

# Check if already intalled
# install httpd package

$global_node = node[:platform]

package 'install httpd' do
    package_name 'httpd'
    action :install
    not_if {node['packages'].keys.include?('httpd')}
end

# get remote file

remote_file '/var/www/html/mj.png' do
	source 'https://railsware.com/blog/wp-content/uploads/2017/12/Chef.png'
	action :create_if_missing
end

# modify startup file


if node[:createTemplate]=='create'
    template '/var/www/html/index.html' do
	source 'index.html.erb'
        action :create
	notifies :create ,'file[/tmp/notification]', :immediately
    end
end


# run httpd service on port 80

service 'httpd' do
    action [:enable , :start]
end


# notify
#
file '/tmp/notification' do
	action :nothing
	content 'This is post notification from template creation'
end

file '/tmp/subscribe' do
	action :nothing
	content 'This is subscribe from notification'
	subscribes :create , 'file[/tmp/notification]' , :immediately
	
end
