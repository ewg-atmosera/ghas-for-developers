# Use GitHub CLI commands to change the visibility of all public repos in the current organization to internal.

# Prompt the user to enter the organization name
echo "Enter the organization name:"
read org_name

# Get the list of all public repos in the specified organization
gh repo list "$org_name" --visibility=public --json name --jq '.[].name' > public-repos.txt

# Loop through the list of public repos and change their visibility to internal
while IFS= read -r repo; do
  gh repo edit "$org_name/$repo" --visibility internal
done < public-repos.txt

# Remove the temporary file
rm public-repos.txt
