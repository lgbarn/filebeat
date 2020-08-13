.PHONY:	all
all:	/bin/filebeat configure_filebeat configure_filebeat_modules

/bin/filebeat:
	@echo Installing filebeat...
	@sudo curl -L -O https://artifacts.elastic.co/downloads/beats/filebeat/filebeat-7.8.1-x86_64.rpm
	@sudo yum -y localinstall filebeat-7.8.1-x86_64.rpm
	@sudo rm filebeat-7.8.1-x86_64.rpm
	@sudo systemctl enable filebeat
	@sudo systemctl start filebeat

.PHONY configure_filebeat: /etc/filebeat/filebeat.yml
configure_filebeat:
	@echo Configuring filebeat...
	@sudo cp files/filebeat.yml /etc/filebeat/filebeat.yml
	@sudo systemctl restart filebeat

.PHONY configure_filebeat_modules: 
configure_filebeat_modules:
	@echo Configuring filebeat modules...
	@sudo filebeat modules enable auditd iptables system
