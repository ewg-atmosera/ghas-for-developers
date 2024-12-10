# CodeQL Manual Trigger Setup

## Useful Links

- [GitHub Action Manual Trigger](https://docs.github.com/en/actions/managing-workflow-runs-and-deployments/managing-workflow-runs/manually-running-a-workflow)

## Instructions

1. Ensure you have completed the [05 Codeql Advanced Setup](./06_codeql_manual_trigger.md) demo.

1. In your new repo, click the top tab `Actions`, then side tab `CodeQL Advanced`.

1. Click the `codeql.yml` file link under the title "CodeQL Advanced". This will take you directly to the YML file so it can be edited in the browser.

1. At the top of the source code, click the pencil icon in the right-side toolbar to edit the file.

1. Update the `on` section to look like this:

    ```yml
    on:
        push:
            branches: [ "main" ]
        pull_request:
            branches: [ "main" ]
        schedule:
            - cron: '38 21 * * 2'
        workflow_dispatch:
    ```

1. Commit the changes using the same method as the [05 Codeql Advanced Setup](./06_codeql_manual_trigger.md) demo.

1. The workflow will run automatically. Let it complete, then we will manually trigger the workflow.

1. Click the `Actions` tab, then click the `CodeQL Advanced` workflow.

1. There will be a `Run workflow` button in the upper-right corner above the workflow history. Click it.

1. Select the branch to run the workflow on, then click the `Run workflow` button.

1. Review the results as normal.
