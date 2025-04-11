# Code Scanning

Code scanning is performed with a tool called [CodeQL](https://codeql.github.com/). CodeQL is a static analysis engine that can be used to find security vulnerabilities in code. It is open source and can be used to analyze code in any language.

GitHub provides support for CodeQL in the following languages:

- [JavaScript](https://codeql.github.com/docs/languages/javascript/)
- [TypeScript](https://codeql.github.com/docs/languages/typescript/)
- [Python](https://codeql.github.com/docs/languages/python/)
- [Java](https://codeql.github.com/docs/languages/java/)
- [C](https://codeql.github.com/docs/languages/c/)
- [C++](https://codeql.github.com/docs/languages/cpp/)
- [C#](https://codeql.github.com/docs/languages/csharp/)
- [Go](https://codeql.github.com/docs/languages/go/)
- [Ruby](https://codeql.github.com/docs/languages/ruby/)
- [Swift](https://codeql.github.com/docs/languages/swift/)

While GitHub only supports these languages, CodeQL can be used to analyze code in any language. For more information, see [CodeQL documentation](https://codeql.github.com/docs/).

## Metadata

[Metadata for CodeQL Queries](https://codeql.github.com/docs/writing-codeql-queries/metadata-for-codeql-queries/)

### Kind, Precision, and Problem Severity

[GitHub CodeQL Query Metadata Style Guide](https://github.com/github/codeql/blob/main/docs/query-metadata-style-guide.md#query-type-kind)

- `@kind`
  - Alert: queries that highlight issues in specific locations in your code. - Problem at a single location.
  - Path: queries that describe the flow of information between a source and a sink in your code. - Problem that flows through multiple locations.
- `@precision`
  - Very High (`very-high`): queries that are guaranteed to be correct. 
  - High (`high`): queries that are very likely to be correct.
  - Medium (`medium`): queries that are likely to be correct.
  - Low (`low`): queries that may have false positives.
- `@problem.severity`
  - Error (`error`): a problem that must be fixed.
  - Warning (`warning`): a problem that should be fixed.
  - Recommendation (`recommendation`): a problem that may be fixed.

### Security Severity

- `@tags security` - for queries that detect security weaknesses.
- `@tags quality` - for queries that detect code quality issues.
- `@security-severity` - level of severity between 0.0. and 10.0. [More Info](https://www.first.org/cvss/v3-1/specification-document#Qualitative-Severity-Rating-Scale)

