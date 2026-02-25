# Git Commands to Push ArulKumar's DevOps Assignment to GitHub

# Step 1: Configure Git (if not already done)
git config --global user.name "ArulKumar"
git config --global user.email "arulkumarcn-dev@users.noreply.github.com"

# Step 2: Initialize Git repository
git init

# Step 3: Add remote repository
git remote add origin https://github.com/arulkumarcn-dev/Devops-DAP.git

# Step 4: Add all files to staging
git add .

# Step 5: Commit with message
git commit -m "Initial commit - DevOps Sharpened DAP Completion Assignment by ArulKumar"

# Step 6: Push to GitHub
git branch -M main
git push -u origin main

# If using SSH instead:
# git remote set-url origin git@github.com:arulkumarcn-dev/Devops-DAP.git
# git push -u origin main

# Note: Make sure to add your SSH key to GitHub account:
# Settings > SSH and GPG keys > New SSH key
# Paste your public key: ssh-ed25519 AAAAC3NzaC1lZDI1NTE5AAAAIJj3l7iv3BEo6NZoxbMSJ0nINPsvxgsiu67NSGSWprnz
