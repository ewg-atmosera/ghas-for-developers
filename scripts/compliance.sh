#!/bin/bash

# Security Policy Compliance Checker
# Purpose: Verify if all repositories adhere to the organization's security policy (e.g., LICENSE, SECURITY.md, CONTRIBUTING.md files present).

# Define organization and required files
ORG="gh-workflows" # Change this to your organization name
REQUIRED_FILES=("README.md" "LICENSE")


# Function to check and auto-generate missing files
check_and_generate_files() {
    repo=$(echo "$1" | tr -d '\r') # Remove carriage return from repo name
    for file in "${REQUIRED_FILES[@]}"; do
        file=$(echo "$file" | tr -d '\r') # Remove carriage return from file name
        # Check if file exists
        if ! gh api "repos/$ORG/$repo/contents/$file" --silent > /dev/null 2>&1; then
            echo "$file is missing in $repo. Auto-generating..."
            # Auto-generate file (example: echo "Content" > $file)
            # Note: Customize the generation of each file as needed
            echo "This is an auto-generated $file." > "$file"
            # Prepare the content for uploading
            content=$(base64 < "$file" | tr -d '\n')
            # Commit the file to the repository
            gh api --method PUT "repos/$ORG/$repo/contents/$file" \
                -f message="Auto-generate missing $file" \
                -f content="$content" \
                -f branch="main" # Adjust branch name as necessary
            echo "$file auto-generated and committed to $repo."
        else
            echo "$file exists in $repo."
        fi
    done
}
# Fetch all repositories in the organization
REPOS=$(gh api orgs/$ORG/repos | jq -r '.[].name')

# Loop through each repository and check for required files
for repo in $REPOS; do
    echo "Checking $repo..."
    check_and_generate_files $repo
done