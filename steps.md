// Load Balancer <<< Public/Private 
0. Create myRG - myVnet 
1. Create Load Balancer 
2. Create front-ip 
3. Create BackEndPool >> add instances 
4. Create LB-Rule 
80 front-ip | BackEndPool 80
5. NAT 
6. Create LB 
sudo apt update -y 
sudo apt install apache2 -y
sudo systemctl enable apache2
sudo systemctl start apache2
cd /var/www/html 
sudo chmod 755 /var/www/html 
sudo rm index.html 
sudo nano index.html                            <h1>webserver1</h1>













// VMSS - instances 

VMSS >> LB 

instances - 3 
rule - policy 

 
 # Azure VMSS with Public Load Balancer
* Create Resource Group
* Create Virtual Network and Subnet
* Create `script.sh`
```bash
#!/bin/bash
apt update -y
apt install apache2 -y
systemctl enable apache2
systemctl start apache2
HOSTNAME=$(hostname)
echo "<h1>Webserver: $HOSTNAME</h1>" > /var/www/html/index.html
```
* Go to Azure Portal
* Open VM Scale Sets
* Click Create
* Select Ubuntu 22.04
* Select VM Size
* Set Instance Count = 2
* Select Uniform Orchestration
* Select Existing VNet and Subnet
* Enable Azure Load Balancer
* Select Public Standard Load Balancer
* Create Frontend IP
* Create Backend Pool
* Create Health Probe Port 80
* Create Load Balancing Rule 80:80
* Advanced → Custom Data
* Paste `script.sh`
* Review + Create
* Create VMSS
* Copy Load Balancer Public IP
* Open Browser
```text
http://<LoadBalancer-Public-IP>
```
* Refresh browser multiple times
* Observe different VM hostnames
* Validate Apache
```bash
sudo systemctl status apache2
```
* Check Port 80
```bash
sudo ss -tunlp | grep 80
```
* Check Cloud Init Logs
```bash
cat /var/log/cloud-init-output.log
```
* VMSS provides High Availability
* Load Balancer distributes traffic
* Health Probe checks VM health
* Supports Autoscaling
* Standard Load Balancer recommended for Production

// windows (private LB+VMSS)
```
// Private Load Balancer
1. create RG - myRG
2. Launch 2 webservers
server1, server2
same vnet*
* SG - http, https, rdp
3.
Server Manger >> Add Roles and Features >> IIS (Internet Information Services)
C:/inetpub/wwwroot/index.html
4. create loadbalancer - type:internal*
5. create front-ip
6. create backend pool - select >> add instances >> add vmss
7. create rule - front-ip:backendpool 80:80
8. create health-probe
9. create load balancer
10. check url at local and as well as in rdp http://172.16.0.6/


VMSS + LB

0.create stotrage account >> mycontainer >> script.ps1
1. create vmss - myvmss
2. instance count -
max - 3
desired - 2
min - 1
3. automatic policy - scale manually - 4 - save | save
4. vmss >> settings >> add extension >> windows script >> storage account (select script)
5. vmss restart*

script:
check file working-script-IIS.ps1
from
https://github.com/atulkamble/azure-vmss-lb-project/
```
