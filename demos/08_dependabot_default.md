# Dependabot Default Settings

## Useful Links

- [Dependabot Quick Start](https://docs.github.com/en/code-security/getting-started/dependabot-quickstart-guide)

## Instructions

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

1. In your new repo, click the top tab `Security`, then click the side tab `Dependabot`.

1. Review the Dependabot alerts. There will be some high, moderate, and low serverity alerts. These alerts are for outdated dependencies in the project. Additionally, you will start to receive email notifications for these alerts.

1. Review the first Dependabot alert it should be a high severity alert. After reviewing the alert, click the `Create Dependabot security update` button. It will take a few moments for the security update to be generated.

1. To view the security update, click the `Pull requests` tab. You will see the security update pull request. Review the changes but do not merge the pull request.

1. By this point, you should have received some emails from GitHub about the Dependabot alerts. Review the emails and the alerts in the GitHub UI.

1. In your new repo, click the top tab `Security`, then click the side tab `Dependabot`.

1. In the upper-right corner, click the `Configure` button, and select `Manage repository vulnerability settings`.

    **Note:** The other two options, `Manage Dependabot rules` and `Manage account notification settings` can be accessed from this button or from within the repo security settings accessed through the first option.

1. Review the dependency and Dependabot settings. You can change the settings to meet your needs. For example, you can change the frequency of Dependabot alerts, or you can change the severity level of alerts that you want to receive.

1. Click the gear icon to edit the Dependabot rules. Click the `New rule` button to add a new rule with the following settings:

    - Rule Name: Low Severity Dismiss Until Path Then PR 
    - State: Enabled
    - Target alerts: severity:low
    - Dismiss Alerts: checked
    - Until patch is available: selected
    - Open a pull request to resolve alerts: selected

    Then, click the `Create rule` button.

1. Click the large `Code Security` link at the top of the `Dependabot` rules page. Then click the `Configure alert notifications` link under `Dependabot alerts`.

1. Scroll down to `Dependabot alerts: New vulnerabilities`. Review the configuration options.