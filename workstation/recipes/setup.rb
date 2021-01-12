$global_variable = 'global'
  

package 'install package for workstation' do
    case node[:platform]

    when 'redhat','centos'
        Chef::Log.info(" Node classified as #{node[:platform]}*************** #$global_variable")
        Chef::Log.info("Is Httpd installed : #{node['packages'].keys.include?('tree')}")
        package_name ['tree','vim','vim-enhanced','nano']
    when 'ubuntu', 'debian'
        package_name 'apache2'

    end

    action :install

end


# file '/etc/mod' do
#     content 'This is MJ Chef server'
#     owner 'root'
#     group 'root'
#     action :create_if_missing
#     only_if {node[:platform]=='centos'}

# end


if node[:rimnode]
    template '/etc/motd' do
        source 'motd.erb'
        action :create
        variables(
            host_name: node[:hostname],
            ipaddress: node[:ipaddress],
            message: node[:message]
        )
    end
end
