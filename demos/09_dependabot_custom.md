# Dependabot Custom Settings

## Useful Links

- [Dependabot YAML](https://docs.github.com/en/code-security/supply-chain-security/keeping-your-dependencies-updated-automatically/configuration-options-for-dependency-updates)

## Instructions

### Part 1 - Project Setup

**IMPORTANT:** Only complete part 1 if you did not complete Flask App setup in the previous demo. If you completed the previous demo and did not delete the repo, you can use that repo for this demo.

1. Ensure you have a GitHub Advanced Security license. Check with you administrator if you are unsure.

1. Clone the public repo, `https://github.com/ewg-atmosera/flask_app`, to your local computer.

    ```sh
    git clone https://github.com/ewg-atmosera/flask_app
    ```

1. Create a new repo in your GitHub account named `flask_app`, and push the clone repo to it.

    ```sh
    git remote add explore-dependency-scanning <YOUR GIT REPO URL>
    ```

    ```sh
    git push explore-dependency-scanning main
    ```

### Part 2 - Dependabot Alerts

1. In your repo, click on the top `Settings` tab, click on the left-side tab `Code security`.

1. Locate `Dependabot version updates`, then click the `Enable` button adjacent to it.

1. This will create `dependabot.yml` file in the `.github` folder. This file is used to configure Dependabot alerts. This enables the Dependabot settings to be configured within the repo source code as opposed to the GitHub site. This is an example of infrastructure as code, makes it easier to manage and track changes to your configuration.

1. For this demo, we will explore the integrated GitHub Copilot chat for configuring this file. Click the `Copilot icon` at the top of the GitHub web page.

1. Type the following prompt into the Copilot chat window.

    ```text
    Create a useful GitHub dependabot.yml file for my repo which contains a Python Flask app. I would like to be notified daily of alerts. I would like PRs to be automatically created once a patch is available for an alert. Please only notify me about moderate and high severity alerts.
    ```

    Copilot will respond with something similar to this.

    ```yaml
    version: 2
    updates:
    - package-ecosystem: "pip"
        directory: "/"
        schedule:
            interval: "daily"
        commit-message:
            prefix: "fix"
        open-pull-requests-limit: 5
        ignore:
            - dependency-name: "*"
                update-types: ["version-update:semver-major"]
        pull-request-branch-name:
            separator: "-"
        rebase-strategy: "auto"
        labels:
            - "dependencies"
        commit-message:
            include: "scope"
        reviewers:
            - "ericwgreene"
        assignees:
            - "ericwgreene"
        allow:
            - dependency-type: "all"
        milestone: "dependabot"
        automerge: true
        security-advisories:
            severity-levels:
                - "moderate"
                - "high"
    ```

1. Copy and paste the YAML code into the `dependabot.yml` file editor.

1. Click the `Commit changes...` button to save the file. Complete the commit form and click the `Commit changes` button. Close the Copilot chat window.
