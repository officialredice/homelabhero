# Create main directory
mkdir -p homelab-hero-enterprise-network && cd homelab-hero-enterprise-network

# Create base files
touch README.md LICENSE .gitignore

# Create core episode folders and subfiles
mkdir -p 01_lab-setup/virtualbox-configs
touch 01_lab-setup/topology-diagram.png
touch 01_lab-setup/network-planning.md

mkdir -p 02_freeipa
touch 02_freeipa/install-script.sh
touch 02_freeipa/config-guide.md
touch 02_freeipa/ipa-users.csv

mkdir -p 03_dns-dhcp/bind-configs
touch 03_dns-dhcp/dhcpd.conf

mkdir -p 04_file-server
touch 04_file-server/smb.conf
touch 04_file-server/setup-notes.md

mkdir -p 05_firewall
touch 05_firewall/pfsense-rules.json
touch 05_firewall/vlans-diagram.png

mkdir -p 06_monitoring/zabbix-templates
touch 06_monitoring/zabbix-config-guide.md

mkdir -p 07_logging/rsyslog-configs
touch 07_logging/wazuh-setup.md

# Create documentation folder
mkdir -p docs
touch docs/lab-overview.md docs/faqs.md docs/glossary.md

# Initialize git repo
git init

echo "✅ Project structure created. You're ready to build!"
