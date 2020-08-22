file "/home/ec2-user/hello.txt" do
    action :create
end

package "httpd" do
    action :install
end