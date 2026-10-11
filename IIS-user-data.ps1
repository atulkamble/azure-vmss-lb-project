<powershell>

# Install IIS Web Server
Install-WindowsFeature -Name Web-Server -IncludeManagementTools

# Start IIS Service
Start-Service W3SVC

# Enable IIS Automatic Startup
Set-Service W3SVC -StartupType Automatic

# Get VM Hostname
$hostname = $env:COMPUTERNAME

# Create Custom IIS Webpage
$html = @"
<!DOCTYPE html>
<html>
<head>
    <title>Azure IIS Web Server</title>
    <style>
        body {
            font-family: Arial;
            text-align: center;
            background-color: #0078D4;
            color: white;
            padding-top: 100px;
        }
    </style>
</head>
<body>
    <h1>Welcome to Azure IIS Web Server</h1>
    <h2>Cloudnautic Azure VM Demo</h2>
    <h3>Server Hostname: $hostname</h3>
    <p>Deployed using PowerShell Custom Data</p>
</body>
</html>
"@

# Deploy HTML Page
$html | Out-File -FilePath "C:\inetpub\wwwroot\index.html" -Encoding UTF8

# Allow HTTP Port 80
New-NetFirewallRule `
    -DisplayName "Allow HTTP Port 80" `
    -Direction Inbound `
    -Protocol TCP `
    -LocalPort 80 `
    -Action Allow

# Restart IIS
iisreset

</powershell>
