#!/bin/bash
set -euo pipefail

sudo dnf update -y

# Install Nginx
sudo dnf install -y nginx

# Nginx service: Start, Enable and status
sudo systemctl start nginx
sudo systemctl enable nginx

sudo systemctl status nginx

cat <<'EOF' > /usr/share/nginx/html/index.html
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>HUG Lagos/Ibadan Terraform Challenge</title>
    <style>
        :root {
            --bg-page: #000000;        
            --bg-card: #0A0A0A;       
            --border: #262626;       
            
            --text-primary: #FFFFFF;  
            --text-secondary: #A1A1AA;
            --text-muted: #52525B;     
            
            --font-main: 'SF Pro Display', -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, Oxygen, Ubuntu, Cantarell, sans-serif;
        }

        * {
            box-sizing: border-box;
        }

        body {
            margin: 0;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            font-family: var(--font-main);
            background-color: var(--bg-page);
            color: var(--text-primary);
            overflow: hidden;
        }

        .container {
            position: relative;
            padding: 2rem;
            width: 100%;
            max-width: 600px;
        }

        .challenge-card {
            background-color: var(--bg-card);
            border: 1px solid var(--border);
            border-radius: 12px;
            padding: 3rem;
            text-align: center;
            position: relative;
        }

        .platform-badge {
            display: inline-flex;
            align-items: center;
            padding: 0.4rem 0.9rem;
            background-color: #18181B;
            border: 1px solid var(--border);
            border-radius: 99px;
            font-size: 0.75rem;
            font-weight: 700;
            letter-spacing: 0.1em;
            text-transform: uppercase;
            color: var(--text-primary);
            margin-bottom: 2.5rem;
        }

        .participant-name {
            font-size: 3rem;
            font-weight: 800;
            letter-spacing: -0.04em;
            margin: 0 0 0.5rem 0;
            line-height: 1.1;
            color: var(--text-primary);
        }

        .challenge-title {
            font-size: 1.1rem;
            font-weight: 400;
            color: var(--text-secondary);
            margin: 0;
            margin-bottom: 3rem;
        }

        .tech-stack {
            font-size: 0.8rem;
            color: var(--text-muted);
            border-top: 1px solid var(--border);
            padding-top: 1.5rem;
            margin-top: 1rem;
            text-transform: lowercase;
            letter-spacing: 0.05em;
        }

        @media (max-width: 480px) {
            .participant-name { font-size: 2.2rem; }
            .challenge-card { padding: 2rem; }
        }
    </style>
</head>
<body>
    <div class="container">
        <div class="challenge-card">
            <div class="platform-badge">
                DEPLOYED | TERRAFORM
            </div>
            
            <h1 class="participant-name">Ogechukwu Okoli</h1>
            <h2 class="challenge-title">HUG Lagos/Ibadan Terraform Challenge</h2>
            
            <div class="tech-stack">
                infrastructure via aws ec2 | server via nginx
            </div>
        </div>
    </div>
</body>
</html>
EOF