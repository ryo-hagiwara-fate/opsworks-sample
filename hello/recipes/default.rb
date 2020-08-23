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