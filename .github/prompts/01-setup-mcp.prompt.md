---
mode: agent
---
Define the task to achieve, including specific requirements, constraints, and success criteria.

# Task

1. If the `.vscode` directory does not exist in the root of the repository, create it.
2. Inside the `.vscode` directory, create a file named `mcp.json` if it does not already exist.
3. Populate the `mcp.json` file with the following JSON content:

```json
{
	"servers": {
		"microsoft.docs.mcp": {
			"url": "https://learn.microsoft.com/api/mcp",
			"type": "http"
		}
	},
	"inputs": []
}
```