# Remove Secret from Repo

## Useful Links

- [Removing sensitive data from a repository](https://docs.github.com/en/github/authenticating-to-github/keeping-your-account-and-data-secure/removing-sensitive-data-from-a-repository)

## Secret in Last Commit Instructions

Removing a secret from the last commit is easy. Simply, amend the last commit and push the changes.

```bash
git add <FILE_CHANGED>
```

```bash
git commit --amend
```

```bash
git push -f
```

## Secret in Previous Commits Instructions

This is more complicated, and requires rewriting the Git history to remove the secret. This particular example requires Python to be installed.

1. Install the `git-filter-repo` package.

    ```sh
    pip install git-filter-repo
    ```

1. Run the following command to remove the secret from the entire Git history. Replace `your-secret` with the actual secret you want to remove. This command will rewrite the Git command history, so be careful when using it, and notify your team members before doing so.

    ```sh
    git filter-repo --path-glob '*' --replace-text <(echo "your-secret==>REMOVED_SECRET")
    ```

    **Note:** This command expects to be performed on a freshly cloned repo. If your repo is not freshly cloned (such as having multiple remotes), you may need to use the `--force` flag.

    ```sh
    git filter-repo --force --path-glob '*' --replace-text <(echo "your-secret==>REMOVED_SECRET")
    ```

1. Next, the repo needs to be cleaned up. The following commands will remove the original refs and expire the reflog, and then run the garbage collector to prune the repo. If this is not done, the original commits can still be accessed.

    ```sh
    rm -rf .git/refs/original/
    ```

    ```sh
    git reflog expire --expire=now --all
    ```

    ```sh
    git gc --prune=now --aggressive
    ```

1. Push the changes to the remote repository. This will overwrite the remote history with the new history, please notify your team members before doing so.

    ```sh
    git push origin --force --all
    ```

    ```sh
    git push origin --force --tags
    ```

1. Update any secret scanning alerts as appropriate.
