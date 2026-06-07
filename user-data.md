```
#!/bin/bash
apt update -y
apt install apache2 -y
systemctl enable apache2
systemctl start apache2
cd /var/www/html || exit
rm -f index.html
HOSTNAME=$(hostname)
cat <<EOF > index.html
<h1>Azure VMSS Instance</h1>
<h2>Hostname: $HOSTNAME</h2>
EOF
```
