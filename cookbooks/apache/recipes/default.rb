#
# Cookbook Name:: apache
# Recipe:: default
#
# Copyright 2016, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#
if node["platfom"] == "ubuntu"
   execute "apt-get update -y" do
   end
end

package "webserver" do
        package_name node["apache"]["package"] 
end

node["apache"]["sites"].each do |sitename , data|
     document_root = "/content/sites/#{sitename}"
     
     directory document_root do
               mode "0755"
               recursive true
     end

execute "rm /etc/httpd/conf/README" do
        only_if do
              File.exist?("/etc/httpd/conf/README")
        end
        notifies :restart, "service[apacheservice]"
end

if node["platform"] == "ubuntu" 
  template_location = "/etc/apache2/sites-enabled/#{sitename}.conf"
elsif node["platform"] == "centos"
  template_location = "/etc/httpd/conf.d/#{sitename}.conf"
end

template  template_location  do
      source "vhosts.erb"
      mode "0644"
      variables(
                 :document_root => document_root,
                 :port => data["port"],
                 :domain => data["domain"] 
               )
      notifies :restart, "service[apacheservice]"
end 

template "/content/sites/#{sitename}/index.html" do
         source "index.html.erb"
         mode "0644"
         variables(
         :site_title => data["site_title"],
         :site_content => "this is added to the website"
         )

end
end  
service "apacheservice" do
        service_name node["apache"]["package"]
        action [:enable , :start]
end

#include_recipe "php::default"
