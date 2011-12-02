# Set up mysql for a redmine site

execute "mysql setup" do
  command "mysql <<EOF
create database redmine;
create user redmine;
grant all privileges on redmine.* to redmine;
flush privileges;
EOF
"
  action :run
  not_if "mysql mysql < <(echo 'show databases;') | grep -q ^redmine$"
end

template "/var/www/redmine/config/database.yml" do
  source "database.yml.erb"
  action :create
end

