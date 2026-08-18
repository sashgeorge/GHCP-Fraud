$ErrorActionPreference = 'Stop'

[void][Console]::In.ReadToEnd()

@{
    continue = $true
    systemMessage = 'Follow .github/copilot-instructions.md. Preserve UC-to-AC-to-issue-to-test-to-PR traceability, use only synthetic or approved de-identified data, and do not claim unobserved validation or approval.'
} | ConvertTo-Json -Compress