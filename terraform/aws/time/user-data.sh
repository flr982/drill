#!/bin/bash

# Install required packages
sudo dnf install -y httpd

# Start and enable Apache (httpd) service
sudo systemctl start httpd
sudo systemctl enable httpd

# Get the EC2 instance hostname
EC2_HOSTNAME=$(hostname)

# Create an HTML page that shows the current time and EC2 hostname
cat <<EOF | sudo tee /var/www/html/index.html
<!DOCTYPE html>
<html>
<head>
    <title>Current Time & Hostname</title>
    <meta http-equiv="refresh" content="1"> <!-- Refresh every second -->
    <style>
        body { font-family: Arial, sans-serif; text-align: center; padding: 50px; }
        h1 { font-size: 3em; }
        h2 { font-size: 2em; color: gray; }
    </style>
</head>
<body>
    <h1>Current Time:</h1>
    <h1 id="time"></h1>
    <h2>Hostname: $EC2_HOSTNAME</h2>
    <script>
        function updateTime() {
            document.getElementById("time").innerText = new Date().toLocaleTimeString();
        }
        setInterval(updateTime, 1000);
        updateTime();
    </script>
</body>
</html>
EOF


# Open HTTP port in the firewall
# sudo firewall-cmd --add-service=http --permanent
# sudo firewall-cmd --reload

