Param (
    # Access token
    [Parameter(Mandatory = $true)]
    [string] $Token,

    # Username
    [Parameter(Mandatory = $true)]
    [string] $Username
)

$apiVersion = "2022-11-28"

$headers = @{
    'Accept'               = 'application/vnd.github+json'
    'Authorization'        = 'Bearer ' + $Token
    'X-GitHub-Api-Version' = $apiVersion
}

Invoke-RestMethod `
    -Uri https://api.github.com/users/$Username/starred `
    -Method Get `
    -Headers $headers `
| ConvertTo-Json `
| Out-File "stars.json"
