template "#{node.nginx.dir}/sites-available/maplify_api.conf" do
  source 'maplify_api.conf.erb'
  mode '0644'
  notifies :reload, 'service[nginx]', :delayed
end

nginx_site 'maplify_api.conf'
