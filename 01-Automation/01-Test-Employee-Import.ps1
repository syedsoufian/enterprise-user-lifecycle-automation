Import-Module ActiveDirectory

$employees = Import-Csv ".\employees.csv"

foreach ($employee in $employees) {

    $existingUser = Get-ADUser `
        -Filter "SamAccountName -eq '$($employee.Username)'" `
        -ErrorAction SilentlyContinue

    if ($existingUser) {
        Write-Host "FOUND: $($employee.Username)" -ForegroundColor Green
    }
    else {
        Write-Host "NOT FOUND: $($employee.Username)" -ForegroundColor Yellow
    }
}