# CodeQL Custom Queries in GitHub Action

## Useful Links

- [Customizing your advanced setup for code scanning](https://docs.github.com/en/code-security/code-scanning/creating-an-advanced-setup-for-code-scanning/customizing-your-advanced-setup-for-code-scanning)

## Instructions

1. This demo builds on the previous [demo](./08_codeql_custom_query.md). Please complete the previous demo before continuing.

1. Open the `web_app` folder in your code editor.

1. In the root folder, create a new folder named `.github`. Within the `.github` folder, create a new folder named `workflows`.

1. In the `workflows` folder, create a new file named `codeql.yml`. Add the following content to the file.

    ```yml
    name: "CodeQL Custom Queries"

    on:
      push:
        branches: [ "main" ]
      pull_request:
        branches: [ "main" ]
      schedule:
        - cron: '34 2 * * 1'
      workflow_dispatch:

    jobs:
      analyze:
        name: Analyze (${{ matrix.language }})
        runs-on: ${{ (matrix.language == 'swift' && 'macos-latest') || 'ubuntu-latest' }}
        permissions:
          security-events: write
          packages: read
          actions: read
          contents: read
        strategy:
          fail-fast: false
          matrix:
            include:
            - language: python
              build-mode: none
        steps:
        - name: Checkout repository
          uses: actions/checkout@v4

        - name: Initialize CodeQL
          uses: github/codeql-action/init@v3
          with:
            languages: ${{ matrix.language }}
            build-mode: ${{ matrix.build-mode }}
            queries: +security-and-quality,./custom-queries
        - if: matrix.build-mode == 'manual'
          shell: bash
          run: |
            echo 'If you are using a "manual" build mode for one or more of the' \
              'languages you are analyzing, replace this with the commands to build' \
              'your code, for example:'
            echo '  make bootstrap'
            echo '  make release'
            exit 1

        - name: Perform CodeQL Analysis
          uses: github/codeql-action/analyze@v3
          with:
            category: "/language:${{matrix.language}}"
    ```

    The line `queries: +security-and-quality,./custom-queries` tells the CodeQL Action to use the default queries and our custom queries.

1. Commit and push your changes. Review the actions to see the execution result of the GitHub Action. Once completed, review the results in the Security tab of the repository.