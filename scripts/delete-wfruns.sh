# Prompt the user to enter the repository name. If left empty the CLI will use the current repository.
read -p "Enter the repository name: " REPO

# Fetch the workflow run IDs
echo "Fetching workflow run IDs from the repository: $REPO"
workflow_run_ids=$(gh run list --repo "$REPO" --json databaseId --jq '.[].databaseId')

if [ -z "$workflow_run_ids" ]; then
  echo "No workflow runs found or failed to fetch workflow runs."
  exit 1
fi

echo "Workflow run IDs fetched: $workflow_run_ids"

# Loop through each workflow run ID and delete it
echo "$workflow_run_ids" | while read id; do
  echo "Deleting workflow run with ID: $id"
  response=$(gh run delete "$id" --repo "$REPO")

  if [ $? -eq 0 ]; then
    echo "Successfully deleted workflow run with ID: $id"
  else
    echo "Failed to delete workflow run with ID: $id."
  fi
done