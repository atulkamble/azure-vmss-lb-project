# Install IIS Web Server
Install-WindowsFeature -Name Web-Server -IncludeManagementTools

# Get VM Hostname
$hostname = $env:COMPUTERNAME

# Create IIS Web Page
$html = @"
<html>
<head>
<title>Azure VMSS IIS Web Server</title>
</head>
<body style="text-align:center;font-family:Arial;">
<h1>Welcome to Azure VMSS</h1>
<h2>IIS Web Server Running Successfully</h2>
<h3>Server Hostname: $hostname</h3>
<p>Powered by Microsoft Azure</p>
</body>
</html>
"@

# Update Default IIS Page
Set-Content -Path "C:\inetpub\wwwroot\index.html" -Value $html

# Start IIS
Start-Service W3SVC

# Enable Automatic Startup
Set-Service W3SVC -StartupType Automatic
