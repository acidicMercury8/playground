$uri = 'http://localhost:8080/task/'
$headers = @{
    'Content-Type' = 'application/json'
}
$form = '{
    "id": "8b171ce0-6f7b-4c22-aa6f-8b110c19f83a",
    "name": "A task",
    "description": "A task that need to be executed at the timestamp specified",
    "timestamp": 1645275972000
}'
Invoke-RestMethod -Uri $Uri -Method Post -Headers $headers -Body $Form
