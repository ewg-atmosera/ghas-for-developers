# Custom Pattern Secret Scanning

1. Ensure you have a GitHub Advanced Security license. Check with you administrator if you are unsure.

1. Clone the public repo, `https://github.com/ewg-atmosera/toolsapp-svelte-website`, to your local computer.

    ```sh
    git clone https://github.com/ewg-atmosera/toolsapp-svelte-website
    ```

1. Create a new repo in your GitHub account named `toolsapp-svelte-website`, and push the clone repo to it.

    ```sh
    git remote add explore-secret-scanning <YOUR GIT REPO URL>
    ```

    ```sh
    git push explore-secret-scanning main
    ```

1. In your new repo, click the top tab `Settings`, then side tab `Code Security`, then scroll down to `Secret scanning` -> `Custom patterns`.

1. Click the button `New pattern`.

1. Name the pattern "Organization".

1. Enter the following value into the `Secret format` field.

    ```text
    'Organization': '[0-9A-Z]{6}'
    ```

1. Enter the following value into the `Test string` field.

    ```text
    'Organization': '1D5GHT'
    ```

1. Click the `Save and dry run` button. GitHub will save the custom pattern and queue up the pattern to search the repo. The dry run will show the results of the pattern search. Once it is done, publish the pattern.

1. The pattern should cause a secret alert to be generated. Click the top tab `Security`, then side tab `Secret scanning`. You should see the secret that was found in the repo. Most likely it will be listed under `Secret scanning`.

1. Custom patterns can be used to search for secrets that are not supported by the default secret scanning. This can be useful for finding secrets that are unique to your organization.
