package "nginx" do
    action :install
end

package "mysql56" do
    action :install
end

package "php56" do
    action :install
end

package "php56-fpm" do
    action :install
end

package "php56-mysqlnd" do
    action :install
end

remote_file '/root/latest-ja.tar.gz' do
    source 'http://ja.wordpress.org/latest-ja.tar.gz'
    owner 'root'
    group 'root'
    mode '0444'
    action :create
end
  
script "install_wordpress" do
    interpreter "bash"
    user        "root"
    cwd         "/root"
    code <<-EOL
      tar xzvf latest-ja.tar.gz
      cd wordpress
      cp -R -p * /usr/share/nginx/html 
    EOL
    action :run
end

service "nginx" do
    action [ :enable, :start]
end

service "php-fpm" do
    action [ :enable, :start]
end


cookbook_file '/var/config.json' do
    source 'config.json'
    owner 'root'
    group 'root'
    mode '0755'
    action :create
end

script "install_cloudwatch_agent" do
    interpreter "bash"
    user        "root"
    cwd         "/root"
    code <<-EOL
      cd /opt/aws
      wget https://s3.amazonaws.com/amazoncloudwatch-agent/amazon_linux/amd64/latest/amazon-cloudwatch-agent.rpm
      rpm -U ./amazon-cloudwatch-agent.rpm
    EOL
    action :run
end

package "https://dl.fedoraproject.org/pub/epel/epel-release-latest-7.noarch.rpm" do
    action :install
end

package "collectd" do
    action :install
end