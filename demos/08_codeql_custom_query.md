# CodeQL Custom Query

## Useful Links

- [GitHub CodeQL Custom Queries Docs](https://docs.github.com/en/code-security/codeql-cli/using-the-advanced-functionality-of-the-codeql-cli/using-custom-queries-with-the-codeql-cli)

## Instructions

1. This demo builds on the previous [demo](./07_codeql_cli.md). Please complete the previous demo before continuing.

1. Open the `web_app` folder in your code editor.

1. In the root folder, of the `web_app` folder, create a new folder named `custom_queries`.

1. Create a new file named `qlpack.yml` in the `custom_queries` folder. Add the following content to the file:

    ```yml
    name: my-python-codeql-queries
    version: 0.1.0
    dependencies:
        codeql/python-all: "*"
    ```

1. Open a termial, ensure you are in the root folder of the `web_app` folder, and run the following command to create a new CodeQL database, if one does not exist.

    ```bash
    codeql database create web-app-db --language=python --source-root src
    ```

1. Analyze the CodeQL database with the default.

    ```bash
    codeql database analyze web-app-db codeql/python-queries --format=csv --output=results.csv
    ```

    > In the previous exercise, we ran a similar command but not did not explicitly specify the `codeql/python-queries` folder. This is because the `codeql` CLI automatically uses the default queries for the language of the database.

1. Let's add our `custom-queries` folder to the list of queries to be executed.

    ```bash
    codeql database analyze web-app-db codeql/python-queries ./custom-queries --format=csv --output=results.csv
    ```

    When we run this it will run the default queries and our custom queries, but we have not defined any custom queries yet. Let's do that now.

1. In the `custom_queries` folder, create a new file named `integer_literal.ql`. Add the following content to the file:

    ```ql
    /**
     * @id py/examples/integer-literal
     * @name Integer literal
     * @kind problem
     * @description Finds places where we use the integer literal `0`
     * @tags integer
     *       literal
     * @problem.severity error
     */

    import python

    from IntegerLiteral literal
    where literal.getValue() = 0
    select literal, "Using the integer literal `0` is not allowed. Please use a more descriptive value."
    ```

1. Run the following command to analyze the CodeQL database with our custom query.

    ```bash
    codeql database analyze web-app-db codeql/python-queries ./custom-queries --format=csv --output=results.csv
    ```
    
    > You should see the results of our custom query in the `results.csv` file. There should be an error for the `x = 0` line in the `app.py` file.

1. Let's add a second custom query to the `custom_queries` folder. Create a new file named `flask_port_8080.ql`. Add the following content to the file:

    ```ql
    /**
     * @name Flask Port 8080 Detection
     * @description Detects Flask applications running on port 8080
     * @kind problem
     * @problem.severity error
     * @id devops-person-org/flask-port-8080
     */

    import python
    import semmle.python.dataflow.new.DataFlow
    import semmle.python.ApiGraphs
    import semmle.python.frameworks.Flask
    
    from API::CallNode call
    where
    call = Flask::FlaskApp::instance().getMember("run").getACall() and
    exists(DataFlow::Node portArg |
        portArg = call.getArgByName("port") and
        portArg.asExpr().(IntegerLiteral).getValue() = 8080
    )
    select call,
    "A Flask app appears to be using port 8080."
    ```

1. Run the following command to analyze the CodeQL database with our custom query.

    ```bash
    codeql database analyze web-app-db codeql/python-queries ./custom-queries --format=csv --output=results.csv
    ```
    
    > You should see the results of our custom query in the `results.csv` file. There should be error for the port 8080 in the `app.py` file.

1. Generate a SARIF file from the results.

    ```bash
    codeql database analyze web-app-db codeql/python-queries ./custom-queries --format=sarif --output=results.sarif
    ```

1. Upload the SARIF file to GitHub.

    First, you need a GitHub Personal Access Token saved to the environment variable `GITHUB_TOKEN`. Then, you can run the following command.

    ```bash
    codeql github upload-results --sarif ./results.sarif --ref refs/heads/main
    ```

    Review the result in the Security tab of the GitHub repository.