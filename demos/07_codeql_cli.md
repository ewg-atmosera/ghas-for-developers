# CodeQL CLI

## Useful Links

- [GitHub CodeQL CLI Docs](https://docs.github.com/en/code-security/codeql-cli)

## Instructions

1. Download the latest "tar.gz" or "zip" file [release](https://github.com/github/codeql-action/releases) of CodeQL.

    > This demo was prepared with [v3.28.14](https://github.com/github/codeql-action/releases/tag/v3.28.14).

1. Extract the archive. Copy the `codeql` directory to a folder outside of your home folder. It is recommended that you update your system path it include the `codeql` directory.

1. Open a terminal and run the following command to verify that CodeQL is installed correctly:

    ```bash
    codeql --version
    ```

    > If did you not update your system path, you will need to use the fully qualified directory name to run CodeQL. For example if you extracted CodeQL to the `/opt` folder, you would run the following command:

    ```bash
    /opt/codeql/codeql --version
    ```

1. Create a new folder for this demo. Place the folder whereever you like to store your programming projects.

    ```bash
    mkdir web_app
    ```

1. Change into the new folder.

    ```bash
    cd web_app
    ```

1. Within the folder, create a new virtual environment.

    ```bash
    python3 -m venv venv
    ```

    Activate the virtual environment.

    **Linux/macOS:**
    ```bash
    source venv/bin/activate
    ```

    **Windows: PowerShell**
    ```bash
    .\venv\Scripts\Activate.ps1
    ```

    **Windows: Command Prompt**
    ```bash
    .\venv\Scripts\activate.bat
    ```

1. Open the folder in your code editor.

1. In the root folder of the project create a `requirements.txt` file, and add the following content to it.

    ```text
    click==5.1
    Flask==1.1.4
    itsdangerous==0.24
    Jinja2==2.10.1
    MarkupSafe==0.23
    Werkzeug==1.0.1
    ```

1. In the root folder of the create a `.gitignore` file, and add the following content to it.

    ```text
    .DS_Store
    venv
    .mypy_cache
    __pycache__
    web-app-db
    results.csv
    results.sarif
    ```

    > Most of the files will be familiar. The `web-app-db` folder is the CodeQL database file we will create with the CodeQL CLI. The `results.csv` file is the results of the CodeQL query we will run. While these files will be used locally, we do not want to commit them to source control.

1. Create `src` folder, and create a file named `app.py` in the `src` folder.

    Add the following code to the `app.py` file:

    ```python
    from flask import Flask

    # Create a Flask application instance
    app = Flask(__name__)

    # Define a route for the root URL
    @app.route("/")
    def hello_world():
        return "Hello, World!"

    x = 0

    # Run the application
    if __name__ == "__main__":
        app.run(debug=True, host="0.0.0.0", port=8080)
    ```

1. It's time to create the database. Run the following command from the terminal from the root folder of the project.

    ```bash
    codeql database create web-app-db --language=python --source-root src
    ```

    - If `codeql` is not in your system path, you will need to use the fully qualified directory name to run CodeQL. 
    - The `--source-root` option is used to specify the root directory of the source code. This is where CodeQL will look for the source files to analyze. In this case, we are telling CodeQL to look in the `src` folder.

    When the command completes, you will see a new folder named `web-app-db` in the root folder of the project. This folder contains the CodeQL database.

1. With the CodeQL database we created, we can now analyze the code CodeQL's default queries. Run the following command from the terminal from the root folder of the project.

    ```bash
    codeql database analyze web-app-db --format=csv --output=results.csv
    ```

    - If `codeql` is not in your system path, you will need to use the fully qualified directory name to run CodeQL.
    - The `--format` option is used to specify the output format of the analysis results. In this case, we are telling CodeQL to output the results in CSV format.
    - The `--output` option is used to specify the name of the output file. In this case, we are telling CodeQL to save the results in a file named `results.csv`.

    When the command completes, you will see a new file named `results.csv` in the root folder of the project. This file contains the results of the analysis. Review the results, you will see one error, Flask is running in debug mode.

1. A CSV file is useful for local review, but code security tools such as Azure DevOps and GitHub Advanced Security use the SARIF format. To generate a SARIF file, run the following command from the terminal from the root folder of the project.

    ```bash
    codeql database analyze web-app-db --format=sarif-latest --output=results.sarif
    ```

    - If `codeql` is not in your system path, you will need to use the fully qualified directory name to run CodeQL.
    - The `--format` option is used to specify the output format of the analysis results. In this case, we are telling CodeQL to output the results in SARIF format.
    - The `--output` option is used to specify the name of the output file. In this case, we are telling CodeQL to save the results in a file named `results.sarif`.

    When the command completes, you will see a new file named `results.sarif` in the root folder of the project. This file contains the results of the analysis in SARIF format.

1. This file can be published to Azure DevOps and GitHub Advanced Security. For example, to publish the results to GitHub Advanced Security, run the following command from the terminal from the root folder of the project.

    - First, you need a GitHub Personal Access Token saved to the environment variable `GITHUB_TOKEN`. Then, you can run the following command.

        Hint: If you are using the GitHub CLI on Linux/macOS, you can run the following command to easily set the `GITHUB_TOKEN` environment variable.

        ```bash
        export GITHUB_TOKEN=`gh auth token`
        ```

    - Second, you will need to create a Git repository on GitHub.com, initialize `web_app` as a Git repo, then commit and push the code.

    - Third, enable GitHub Advanced Security for the repository.

    - Finally, run the following command.

        ```bash
        codeql github upload-results --sarif ./results.sarif --ref refs/heads/main
        ```

        - If `codeql` is not in your system path, you will need to use the fully qualified directory name to run CodeQL.
        - The `upload` command is used to upload the SARIF file to GitHub Advanced Security.
        - The `results.sarif` file is the SARIF file we generated in the previous step.

    When the command completes, you will see the results in GitHub Advanced Security.

1. Log into GitHub.com, navigate to your code repository, click the `Security` tab, then click `Code scanning`. You will see the results of the CodeQL analysis.

1. There is a link named `Tools` in the upper-right corner of the page. Click on `CodeQL` under `Tools`, and you will see your `API upload` under `Setup Types`.

1. There will be a configuration named `Unnamed`. You can review the configuration.

 

