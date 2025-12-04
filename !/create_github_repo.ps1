<#
create_github_repo.ps1

Creates a GitHub repository under the authenticated user (or org if you modify the endpoint),
then initializes a local git repo (if needed), commits current files, adds remote, and pushes.

Usage (recommended):
  # set token in environment (safer)
  $env:GITHUB_TOKEN = 'ghp_xxx'
  .\create_github_repo.ps1 -RepoName "fake-news-detector" -Description "Fake News Detector project"

Alternative (will prompt for token):
  .\create_github_repo.ps1 -RepoName "fake-news-detector"

Requirements:
- PowerShell (Windows)
- Git installed and available in PATH
- GitHub Personal Access Token with `repo` scope (set as env var GITHUB_TOKEN or will be prompted)
#>

param(
    [Parameter(Mandatory=$false)]
    [string]$RepoName,

    [Parameter(Mandatory=$false)]
    [string]$Description = "",

    [Parameter(Mandatory=$false)]
    [switch]$Private
)

function Read-Token {
    if ($env:GITHUB_TOKEN -and $env:GITHUB_TOKEN.Trim().Length -gt 0) {
        return $env:GITHUB_TOKEN
    }

    Write-Host "No GITHUB_TOKEN environment variable found. You can set it with:`n  $env:GITHUB_TOKEN = 'ghp_xxx'`nOr enter a token now (input hidden)." -ForegroundColor Yellow
    $secure = Read-Host "Enter GitHub Personal Access Token (repo scope)" -AsSecureString
    if (-not $secure) { return $null }
    $ptr = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($secure)
    $token = [System.Runtime.InteropServices.Marshal]::PtrToStringBSTR($ptr)
    [System.Runtime.InteropServices.Marshal]::ZeroFreeBSTR($ptr)
    return $token
}

if (-not $RepoName) {
    $RepoName = Read-Host "Enter repository name (e.g. fake-news-detector)"
}

if (-not $RepoName) {
    Write-Host "Repository name is required. Exiting." -ForegroundColor Red
    exit 1
}

$token = Read-Token
if (-not $token) {
    Write-Host "No token provided. Aborting." -ForegroundColor Red
    exit 1
}

$headers = @{ Authorization = "token $token"; 'User-Agent' = 'powershell-create-repo-script' }
$body = @{ name = $RepoName; description = $Description; private = $Private.IsPresent } | ConvertTo-Json

try {
    Write-Host "Creating repository on GitHub: $RepoName ..."
    $response = Invoke-RestMethod -Uri "https://api.github.com/user/repos" -Method Post -Headers $headers -Body $body -ContentType "application/json"
    Write-Host "Repository created: $($response.html_url)" -ForegroundColor Green
}
catch {
    Write-Host "Failed to create repository: $($_.Exception.Message)" -ForegroundColor Red
    if ($_.Exception.Response -ne $null) {
        try { $err = ($_ | ConvertTo-Json -ErrorAction Stop) ; Write-Host $err }
        catch { }
    }
    exit 1
}

# Verify Git is available
try {
    git --version > $null 2>&1
}
catch {
    Write-Host "Git does not appear to be installed or not in PATH. Install Git and run the script again, or push manually using the remote URL shown above." -ForegroundColor Red
    exit 1
}

# Initialize repo if it doesn't exist
if (-not (Test-Path ".git")) {
    git init
}

# Ensure there's something to commit
$hasFiles = (Get-ChildItem -File -Exclude ".git" | Measure-Object).Count -gt 0
if (-not $hasFiles) {
    Write-Host "No files to commit in the current directory." -ForegroundColor Yellow
} else {
    git add .
    try {
        git commit -m "Initial commit" -q
    }
    catch {
        # commit may fail if there's nothing to commit or user/email not configured
        Write-Host "Warning: git commit failed (maybe nothing changed or git user not configured)." -ForegroundColor Yellow
    }
}

# Set main branch and push
try {
    git branch -M main 2>$null
}
catch { }

# Remove existing origin if present and add new
try { git remote remove origin 2>$null } catch { }
$remoteUrl = $response.clone_url
git remote add origin $remoteUrl

Write-Host "Pushing to GitHub... (this may prompt for credentials if your token is not stored in Git)" -ForegroundColor Cyan
try {
    git push -u origin main
    Write-Host "Successfully pushed to $remoteUrl" -ForegroundColor Green
}
catch {
    Write-Host "git push failed: $($_.Exception.Message)" -ForegroundColor Red
    Write-Host "If push failed due to credentials, ensure Git is configured to use your PAT or SSH, or set credential helper. You can also push manually using the remote URL above." -ForegroundColor Yellow
}

Write-Host "Done. Repository URL: $($response.html_url)" -ForegroundColor Green
