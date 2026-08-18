$ErrorActionPreference = 'Stop'

function Write-Decision {
    param(
        [ValidateSet('allow', 'ask', 'deny')]
        [string]$Decision,
        [string]$Reason
    )

    @{
        hookSpecificOutput = @{
            hookEventName = 'PreToolUse'
            permissionDecision = $Decision
            permissionDecisionReason = $Reason
        }
    } | ConvertTo-Json -Depth 4 -Compress
}

$rawInput = [Console]::In.ReadToEnd()

try {
    $payload = $rawInput | ConvertFrom-Json -ErrorAction Stop
}
catch {
    Write-Decision -Decision 'allow' -Reason 'Hook input could not be classified; normal tool permissions still apply.'
    exit 0
}

$toolName = @($payload.toolName, $payload.tool_name, $payload.name) |
    Where-Object { $_ } |
    Select-Object -First 1
$toolInput = @($payload.toolInput, $payload.tool_input, $payload.input, $payload.arguments) |
    Where-Object { $_ } |
    Select-Object -First 1
$toolText = if ($null -eq $toolInput) { '' } else { $toolInput | ConvertTo-Json -Depth 20 -Compress }

$isExecution = $toolName -match '(?i)(execute|terminal|shell|command)'
$isWrite = $toolName -match '(?i)(edit|write|create|delete|move|rename|patch)'

if ($isExecution -and $toolText -match '(?i)git\s+(reset\s+--hard|clean\s+-[^\s]*f|push\s+[^\r\n]*--force|checkout\s+--)') {
    Write-Decision -Decision 'deny' -Reason 'Destructive or history-rewriting Git commands are prohibited by workspace policy.'
    exit 0
}

if ($isWrite -and $toolText -match '(?i)(\.github[\\/](copilot-instructions\.md|instructions[\\/]|agents[\\/]|prompts[\\/]|skills[\\/]|hooks[\\/]))') {
    Write-Decision -Decision 'ask' -Reason 'This operation changes workspace Copilot policy or automation and requires explicit user confirmation.'
    exit 0
}

Write-Decision -Decision 'allow' -Reason 'No guarded operation detected.'