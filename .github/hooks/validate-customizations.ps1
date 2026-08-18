$ErrorActionPreference = 'Stop'

[void][Console]::In.ReadToEnd()
$workspace = (Get-Location).Path
$errors = [System.Collections.Generic.List[string]]::new()

function Add-Error {
    param([string]$Message)
    $errors.Add($Message)
}

function Get-Frontmatter {
    param([string]$Path)

    $content = Get-Content -LiteralPath $Path -Raw
    $frontmatterMatch = [regex]::Match($content, '(?s)^---\r?\n(.+?)\r?\n---\r?\n')
    if (-not $frontmatterMatch.Success) {
        Add-Error "${Path}: missing or malformed YAML frontmatter."
        return $null
    }

    return $frontmatterMatch.Groups[1].Value
}

$instructionFiles = Get-ChildItem -Path '.github/instructions' -Filter '*.instructions.md' -File -Recurse -ErrorAction SilentlyContinue
foreach ($file in $instructionFiles) {
    $frontmatter = Get-Frontmatter -Path $file.FullName
    if ($null -ne $frontmatter -and $frontmatter -notmatch '(?m)^description:\s*.+$') {
        Add-Error "$($file.FullName): description is required."
    }
}

$promptFiles = Get-ChildItem -Path '.github/prompts' -Filter '*.prompt.md' -File -Recurse -ErrorAction SilentlyContinue
foreach ($file in $promptFiles) {
    $frontmatter = Get-Frontmatter -Path $file.FullName
    if ($null -ne $frontmatter -and $frontmatter -notmatch '(?m)^description:\s*.+$') {
        Add-Error "$($file.FullName): description is required."
    }
}

$agentFiles = Get-ChildItem -Path '.github/agents' -Filter '*.agent.md' -File -Recurse -ErrorAction SilentlyContinue
foreach ($file in $agentFiles) {
    $frontmatter = Get-Frontmatter -Path $file.FullName
    if ($null -ne $frontmatter -and $frontmatter -notmatch '(?m)^description:\s*.+$') {
        Add-Error "$($file.FullName): description is required."
    }
}

$skillFiles = Get-ChildItem -Path '.github/skills' -Filter 'SKILL.md' -File -Recurse -ErrorAction SilentlyContinue
foreach ($file in $skillFiles) {
    $frontmatter = Get-Frontmatter -Path $file.FullName
    $folderName = $file.Directory.Name
    if ($null -ne $frontmatter) {
        $nameMatch = [regex]::Match($frontmatter, '(?m)^name:\s*([^\r\n]+)\r?$')
        if (-not $nameMatch.Success) {
            Add-Error "$($file.FullName): name is required."
        }
        elseif ($nameMatch.Groups[1].Value.Trim(' ', '"', "'") -ne $folderName) {
            Add-Error "$($file.FullName): skill name must match folder '$folderName'."
        }
        if ($frontmatter -notmatch '(?m)^description:\s*.+$') {
            Add-Error "$($file.FullName): description is required."
        }
    }
}

$jsonFiles = Get-ChildItem -Path '.github/hooks' -Filter '*.json' -File -Recurse -ErrorAction SilentlyContinue
foreach ($file in $jsonFiles) {
    try {
        Get-Content -LiteralPath $file.FullName -Raw | ConvertFrom-Json -ErrorAction Stop | Out-Null
    }
    catch {
        Add-Error "$($file.FullName): invalid JSON: $($_.Exception.Message)"
    }
}

$markdownFiles = @(Get-ChildItem -Path '.github', 'docs' -Filter '*.md' -File -Recurse -ErrorAction SilentlyContinue)
if (Test-Path -LiteralPath 'README.md' -PathType Leaf) {
    $markdownFiles += Get-Item -LiteralPath 'README.md'
}
foreach ($file in $markdownFiles) {
    $content = Get-Content -LiteralPath $file.FullName -Raw
    foreach ($match in [regex]::Matches($content, '\[[^\]]+\]\(([^)#]+)(?:#[^)]+)?\)')) {
        $target = $match.Groups[1].Value
        if ($target -match '^(?i)(https?://|mailto:)') {
            continue
        }
        $resolvedTarget = [IO.Path]::GetFullPath((Join-Path $file.DirectoryName $target))
        if (-not (Test-Path -LiteralPath $resolvedTarget)) {
            Add-Error "$($file.FullName): broken relative link '$target'."
        }
    }
}

if (Get-Command git -ErrorAction SilentlyContinue) {
    $insideWorktree = & git rev-parse --is-inside-work-tree 2>$null
    if ($LASTEXITCODE -eq 0 -and $insideWorktree -eq 'true') {
        $diffCheck = & git diff --check 2>&1
        if ($LASTEXITCODE -ne 0) {
            Add-Error "git diff --check failed: $($diffCheck -join ' ')"
        }
    }
}

if ($errors.Count -gt 0) {
    @{
        continue = $false
        stopReason = 'Workspace customization validation failed.'
        systemMessage = ($errors -join [Environment]::NewLine)
    } | ConvertTo-Json -Compress
    exit 2
}

@{
    continue = $true
    systemMessage = 'Workspace customization frontmatter, JSON, relative links, and whitespace checks passed.'
} | ConvertTo-Json -Compress