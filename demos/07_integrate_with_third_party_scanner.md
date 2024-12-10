# Integrate with Third Party Scanner

## Overview

This demo will integrate with Codacy. Codacy is a static analysis tool that helps developers improve code quality and security. Codacy integrates with GitHub and other source code management systems to provide automated code review and analysis. Codacy can be used to enforce code quality standards, identify security vulnerabilities, and track code quality metrics over time.

Codacy is a third-party tool that requires a subscription. It provides support for more languages than CodeQL. There are many such services as this, this is just an example for this course.

## Useful Links

- [Sarif Format](https://sarifweb.azurewebsites.net/)
- [Codacy](https://www.codacy.com/)
- [GitHub Action for Codacy](https://github.com/codacy/codacy-analysis-cli-action)
- [GitHub Action Secrets](https://docs.github.com/en/actions/security-for-github-actions/security-guides/using-secrets-in-github-actions)

## Instructions

### Part 1 - Setup Code Repo

**IMPORTANT:** Only complete this setup if you have not already created this repo in a previous demo.

1. Ensure you have a GitHub Advanced Security license. Check with you administrator if you are unsure.

1. Clone the public repo, `https://github.com/ewg-atmosera/buffer-overflow-cpp`, to your local computer.

    ```sh
    git clone https://github.com/ewg-atmosera/buffer-overflow-cpp
    ```

1. Create a new repo in your GitHub account named `buffer-overflow-cpp`, and push the clone repo to it.

    ```sh
    git remote add explore-codeql <YOUR GIT REPO URL>
    ```

    ```sh
    git push explore-codeql main
    ```

### Part 2 - Setup & Run Codacy

1. Click the `Actions` tab for the `buffer-overflow-cpp` repo.

1. In the upper-left, click the `New workflow` button.

1. In the `Search workflows`, type `codacy`, then hit `Enter`.

1. One workflow should appear, `Codacy Analysis`. Click the `Configure` button.

1. Add `workflow_dispatch:` to the `on` section.

1. Review the configuration. You will observe and `output` option set to "results.sarif", and a `format` of "sarif". The `sarif` format is a standard format for static analysis results that can be consumed by many tools.

    > Third-party code scanning tools are initiated with a GitHub Action or a GitHub App based on an event in GitHub, like a pull request. The results are formatted as SARIF and uploaded to the [GitHub Security Alerts](https://github.blog/news-insights/product-news/announcing-third-party-code-scanning-tools-static-analysis-and-developer-security-training/#:~:text=Third%2Dparty%20code%20scanning%20tools%20are%20initiated%20with%20a%20GitHub,track%20and%20suppress%20duplicate%20alerts.) tab. Alerts are then aggregated per tool and GitHub is able to track and suppress duplicate alerts.

1. In the configuration file you will observe the following line.

    ```yml
    project-token: ${{ secrets.CODACY_PROJECT_TOKEN }}
    ```

To call Codacy, you will need to add a secret named `CODACY_PROJECT_TOKEN` to the repo. To set the project token you will need to generate one on the Codacy website.

1. At the top of the repo page, click the `Settings` tab.

1. In the left-side menu, click `Secrets and variables`, then click `Actions`.

1. Click the `New repository secret` button.

1. In the `Name` field, type `CODACY_PROJECT_TOKEN`, and copy the token from Codacy into the `Secret` field. Then, click the `Add secret` button.

1. Click on the `Actions` tab, then click the `Codacy Analysis` workflow.

1. Manually run the workflow by clicking the `Run workflow` button and select the main branch. Review the result. Note the upload sarif task.

1. Review the code scanning alerts. You will see the alerts from Codacy in the `Security` tab.

1. While CodeQL is a powerful tool, it is limited to the languages it supports. Codacy supports many more languages, so it can be used to analyze code that CodeQL cannot. Also, Codacy provides a different set of rules and checks than CodeQL, so it can be used to complement CodeQL analysis.