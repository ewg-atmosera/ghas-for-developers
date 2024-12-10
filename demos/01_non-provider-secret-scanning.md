# Non-Provider Secret Scanning

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

1. In your new repo, click the top tab `Settings`, then side tab `Code Security`, then scroll down to `Secret scanning`.

1. Review the default settings. Push protection for supported secrets should be enabled with everything else being disabled. The secret the repo contains is not a supported secret, so it will not be detected. Supported secrets are API keys, OAuth tokens, and personal access tokens from well-known providers.

1. Enable `Scan for generic secrets` and `Non-provider patterns`. GitHub will then scan the repo for broader range of secrets. It should find the secret in the repo.

1. Click the top tab `Security`, then side tab `Secret scanning`. You should see the secret that was found in the repo. Most likely it will be listed under `Secret scanning` > `Experimental`.

1. Review the secret alert, and then decide how to handle it. Select `Revoked` and type a comment.

    ```text
    Removed from the Tools App REST API configuration.
    ```

1. Revoking the secret will remove it from the secret scanning alert list, but the secret will still be in the repo. You will need to remove it manually.





