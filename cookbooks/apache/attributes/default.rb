default["apache"]["sites"]["abdolrezafeizi-gmail-com4"] = { "site_title" => "abdolrezafeizi-gmail-com4 website" , "port" => 80 , "domain" => "abdolrezafeizi-gmail-com4.mylabserver.com" }
default["apache"]["sites"]["abdolrezafeizi-gmail-com4b"] = { "site_title" => "abdolrezafeizi-gmail-com4b website" ,  "port" => 80 , "domain" => "abdolrezafeizi-gmail-com4b.mylabserver.com" }
default["apache"]["sites"]["abdolrezafeizi-gmail-com2"] = { "site_title" => "abdolrezafeizi-gmail-com2.mylabserver.com website" ,  "port" => 80 , "domain" => "abdolrezafeizi-gmail-com2.mylabserver.com" }
case node["platform"]
when "ubuntu"
   default["apache"]["package"] = "apache2"
when "centos"
   default["apache"]["package"] = "httpd"
end
