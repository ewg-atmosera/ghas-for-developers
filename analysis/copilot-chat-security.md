# Using Copilot Chat to Generate Static Analysis Documentation

This file contains a list of questions that can be used to generate documentation for static analysis tools using Copilot Chat. The questions are divided into sections based on the programming language or technology.

### Python

Recommend static analysis tools for a Python project that focus on security vulnerabilities.

I need a quick review of Bandit with key features and limitations. Also include a sample Bandit command to scan a Python project.

How do I implement Bandit for a Python project built with VS Code?

How do I integrate Bandit into my CI/CD pipeline for automated security checks with GitHub Actions? 

## .NET 

What is the default static analysis tool for .NET projects?

Recommend other static analysis tools to generate SARIF reports that can be integrated into a CI/CD pipeline with GitHub Actions.

What are the steps to configure and generate a SARIF report using Roslyn Analyzers for a .NET project?

How do I integrate the SARIF report into GitHub's Security tab?

## SecurityCodeScan Tool

What is the SecurityCodeScan tool? How does it differ from other static analysis tools?

How do I implement SecurityCodeScan into my Visual Studio 2022 project?

Show a sample SecurityCodeScan.config that demonstrates basic customization. The example should  include enabling specific rules, disabling others, and configuring rule parameters.

How do I integrate SecurityCodeScan into my CI/CD pipeline for automated security checks with GitHub Actions? It needs to be able to use a custom  SecurityCodeScan.config file.

Show an example of the provided workflow that alse uses workflow dispatch to trigger the security scan.

Can I customize the GitHub Actions workflow to fail the build if any security issues are found?



