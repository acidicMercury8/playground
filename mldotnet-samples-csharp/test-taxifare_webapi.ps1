$body = @{
    Vendor_id = "CMT"
    Rate_code = 1.0
    Passenger_count = 1.0
    Trip_distance = 3.8
    Payment_type = "CRD"
}

Invoke-RestMethod "https://localhost:60695/predict" `
    -Method Post `
    -Body ($body | ConvertTo-Json) `
    -ContentType "application/json"
