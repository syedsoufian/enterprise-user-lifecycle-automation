$csvPath = ".\employees.csv"

if (-not (Test-Path $csvPath)) {
    Write-Host "ERROR: employees.csv was not found." -ForegroundColor Red
    exit 1
}

$employees = Import-Csv $csvPath

$requiredColumns = @(
    "FirstName",
    "LastName",
    "Username",
    "Department",
    "JobTitle"
)

$csvColumns = $employees[0].PSObject.Properties.Name

foreach ($column in $requiredColumns) {
    if ($column -notin $csvColumns) {
        Write-Host "ERROR: Required column '$column' is missing." -ForegroundColor Red
        exit 1
    }
}

$validationFailed = $false

foreach ($employee in $employees) {

    $missingFields = @()

    if ([string]::IsNullOrWhiteSpace($employee.FirstName)) {
        $missingFields += "FirstName"
    }

    if ([string]::IsNullOrWhiteSpace($employee.LastName)) {
        $missingFields += "LastName"
    }

    if ([string]::IsNullOrWhiteSpace($employee.Username)) {
        $missingFields += "Username"
    }

    if ([string]::IsNullOrWhiteSpace($employee.Department)) {
        $missingFields += "Department"
    }

    if ([string]::IsNullOrWhiteSpace($employee.JobTitle)) {
        $missingFields += "JobTitle"
    }

    if ($missingFields.Count -gt 0) {
        Write-Host "INVALID: $($employee.Username) - Missing: $($missingFields -join ', ')" -ForegroundColor Red
        $validationFailed = $true
    }
    else {
        Write-Host "VALID: $($employee.Username)" -ForegroundColor Green
    }
}

if ($validationFailed) {
    Write-Host "`nCSV validation FAILED." -ForegroundColor Red
    exit 1
}
else {
    Write-Host "`nCSV validation PASSED." -ForegroundColor Green
    exit 0
}