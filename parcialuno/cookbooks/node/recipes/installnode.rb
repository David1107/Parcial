# Se instalan node, npm, mysql y express requeridos para la ejecución de la aplicación web tomado de https://gist.github.com/neojp/5561946 y https://serverfault.com/questions/637549/epel-repo-for-centos-6-causing-error/654660
bash "downloadsandinstall" do
	user "root"
	code <<-EOH
	sudo su
	rpm -Uvh http://epel.mirror.constant.com/6/i386/epel-release-6-8.noarch.rpm
	sudo yum upgrade ca-certificates --disablerepo=epel -y
	yum --enablerepo=epel-testing install npm -y
	npm install mysql -y
	npm install express -y
	EOH
end
# Se abre el puerto 80 donde se va a comunicar el servicio
bash "open port" do
	user "root"
	code <<-EOH
	iptables -I INPUT 5 -p tcp -m state --state NEW -m tcp --dport 80 -j ACCEPT
	service iptables save
	service iptables restart
	EOH
end
# Se crea la carpeta que va a contener la aplicación
bash "create folder" do
	user "root"
	code <<-EOH
	cd var/
	mkdir app
	cd app
	EOH
end
# Se crea y se copia la información del archivo en la ubicación var/app/main.js
cookbook_file "var/app/main.js" do
	source "main.js"
	mode 0755
	owner "root"
	group "wheel"
	action :create
end
# Se ejecuta el archivo con la aplicación node.js tomado de http://stackoverflow.com/questions/4797050/how-to-run-process-as-background-and-never-die
bash "run" do
	user "root"
	code <<-EOH
	cd /var/app
	nohup node main.js > /dev/null 2>/tmp/log &
	EOH
end

