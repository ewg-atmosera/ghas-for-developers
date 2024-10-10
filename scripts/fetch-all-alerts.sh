# Authenticate to GitHub
gh auth login

# Set your organization name
read -p "Enter the name of the organization: " ORG_NAME

# List all repositories in the organization and iterate over them
gh repo list $ORG_NAME --limit 100 --json name -q '.[].name' | while read REPO_NAME; do
    echo "Fetching alerts for $REPO_NAME in $ORG_NAME..."

# GraphQL query to fetch security alerts for the repository
QUERY=$(cat << EOF
query { 
  repository(owner: "$ORG_NAME", name: "$REPO_NAME") {
    vulnerabilityAlerts(first: 100) {
      nodes {
        createdAt
        dismissedAt
        securityVulnerability {
          package {
            
            name
          }
          severity
          updatedAt
        }
      }
    }
  }
}
EOF
)

    # Execute GraphQL query using gh api
    gh api graphql -f query="$QUERY" | jq .
done