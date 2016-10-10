# Se intala el servidor de mysql
yum_package 'mysql-server'
# Se inicia el servicio de mysql
service 'mysqld' do
  action [ :enable, :start]
end
# Se abre el puerto 3306 donde se va acomunicar el servidor de base de datos
bash "open port" do
	user "root"
	code <<-EOH
	iptables -I INPUT 5 -p tcp -m state --state NEW -m tcp --dport 3306 -j ACCEPT
	service iptables save
	EOH
end
# se intala expect
yum_package 'expect'
# Se copia la conifuración de mysql en el archivo /tmp/configure_mysql.sh
cookbook_file "/tmp/configure_mysql.sh" do
	source "configure_mysql.sh"
	mode 0711
	owner "root"
	group "wheel"
end
# Se ejecuta el archivo creado de configure_mysql.sh
bash "configure mysql" do
 user "root"
 group "wheel"
 cwd "/tmp"
 code <<-EOH
 ./configure_mysql.sh
 EOH
end
# Se copia la conifuración del esquema de sql en el archivo /tmp/create_schema.sql
cookbook_file "/tmp/create_schema.sql" do
	source "create_schema.sql"
	mode 0644
	owner "root"
	group "wheel"
end
# Se ejecuta el archivo creado de create_schema.sql
bash "create schema" do
	user "root"
	cwd "/tmp"
	code <<-EOH
	cat create_schema.sql | mysql -u root -pdistribuidos
	EOH
end


