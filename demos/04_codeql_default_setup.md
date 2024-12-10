# CodeQL Default Setup

## Useful Links

- [CodeQL](https://codeql.github.com/)
- [CodeQL Default Setup](https://docs.github.com/en/code-security/code-scanning/enabling-code-scanning/configuring-default-setup-for-code-scanning)

## Instructions

1. Ensure you have a GitHub Advanced Security license. Check with you administrator if you are unsure.

1. Clone the public repo, `https://github.com/ewg-atmosera/buffer-overflow-cpp`, to your local computer.

    ```sh
    git clone https://github.com/ewg-atmosera/buffer-overflow-cpp
    ```

1. Create a new repo in your GitHub account named `buffer-overflow-cpp`, and push the clone repo to it.

    ```sh
    git remote add explore-code-scanning <YOUR GIT REPO URL>
    ```

    ```sh
    git push explore-code-scanning main
    ```

1. In your new repo, click the top tab `Settings`, then side tab `Code Security`, then scroll down to `Code scanning`.

1. Under `Code scanning` > `Tools` > `CodeQL analysis` click the `Set up` button and then select `Default`.

1. Accept all of the defaults and click the `Enable CodeQL` button.

1. GitHub will configure and run the CodeQL analysis tool. Once the CodeQL analysis is complete, there should be one code scanning alert.

1. Click the top tab `Security`, then side tab `Code scanning alerts`. You should see the code scanning alert that was found in the repo.

1. The analysis should trigger the `cpp/very-likely-overrunning-write` rule. This rule is triggered when a buffer is written to that is likely to be larger than the buffer size.

1. Review the code, and you will see that the `strcpy` function is writing to a buffer that is smaller than the string being copied.

1. You can fix this manually by changing the buffer size to be larger or by using a safer function like `strncpy`. Also, GitHub Copilot can be used to fix the issue. Click the `Generate fix` button. Copilot will need a moment to generate the fix.

1. Review the fix, and commit to a new branch by clicking the `Commit a new branch button`. Accept the default which will include creating a new branch and starting a pull request.

1. Complete the pull request if you desire.