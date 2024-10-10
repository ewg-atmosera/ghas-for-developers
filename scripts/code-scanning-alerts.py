import requests
import os

# Set up GitHub API access
GITHUB_TOKEN = os.getenv('GITHUB_TOKEN')
# Prompt the user for the repository name, store in 'REPO_NAME' variable
REPO_NAME = input("Please enter the repository name: ")
# Prompt the user for the organization name, store in 'OWNER' variable
OWNER = input("Please enter the repository owner: ")


# Set up the headers for the GitHub API requests, including the token and API version 'X-GitHub-Api-Version': '2022-11-28
HEADERS = {
    'Authorization': f'token {GITHUB_TOKEN}',
    'Accept': 'application/vnd.github.v3+json',
    'X-GitHub-Api-Version': '2022-11-28'
}

# Function to fetch code scanning alerts from the repository. 
# Returns a list of alerts.
def fetch_code_scanning_alerts():
    url = f'https://api.github.com/repos/{OWNER}/{REPO_NAME}/code-scanning/alerts'
    response = requests.get(url, headers=HEADERS)
    if response.status_code == 200:
        return response.json()
    else:
        print(f'Failed to fetch alerts: {response.status_code}')
        print(f'Response content: {response.content}')
        return []

def categorize_alerts(alerts):
    categorized = {'low': [], 'medium': [], 'high': [], 'critical': [], 'error': []}
    valid_severities = categorized.keys()
    
    for alert in alerts:
        severity = alert.get('rule', {}).get('severity', 'low')
        if severity not in valid_severities:
            severity = 'low'
        categorized[severity].append(alert)
    
    return categorized

def create_issue_for_alert(alert):
    url = f'https://api.github.com/repos/{OWNER}/{REPO_NAME}/issues'
    title = f"Code Scanning Alert: {alert['rule']['id']}"
    body = f"Found a {alert['rule']['severity']} severity issue in {alert['tool']['name']}.\n\nDescription: {alert['rule']['description']}"
    payload = {'title': title, 'body': body}
    response = requests.post(url, json=payload, headers=HEADERS)
    if response.status_code == 201:
        print(f"Issue created: {response.json()['html_url']}")
    else:
        print(f"Failed to create issue: {response.status_code}")

def main():
    alerts = fetch_code_scanning_alerts()
    categorized_alerts = categorize_alerts(alerts)
    for severity, alerts in categorized_alerts.items():
        for alert in alerts:
            create_issue_for_alert(alert)

if __name__ == '__main__':
    main()