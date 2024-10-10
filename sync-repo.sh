# This script contains the commands to sync the local repository with the remote repository.

# Pull the changes from the remote repository
git pull origin main

# Stage the changes
git add .

# Commit the changes
git commit -m "Sync local repository with remote repository"

# Push the changes to the remote repository
git push origin main