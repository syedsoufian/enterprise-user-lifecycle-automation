Import-Module ActiveDirectory

$employees = Import-Csv ".\employees.csv"

$employeesOU = "OU=Employees,DC=corp,DC=local"

$departmentGroups = @{
    "IT"      = "GG_IT_Support"
    "HR"      = "GG_HR"
    "Finance" = "GG_Finance"
}

$temporaryPassword = Read-Host "Enter temporary password for new employees" -AsSecureString

foreach ($employee in $employees) {

    $existingUser = Get-ADUser `
        -Filter "SamAccountName -eq '$($employee.Username)'" `
        -ErrorAction SilentlyContinue

    if ($existingUser) {
        Write-Host "SKIPPED: $($employee.Username) already exists." -ForegroundColor Yellow
        continue
    }

    $displayName = "$($employee.FirstName) $($employee.LastName)"

    New-ADUser `
        -Name $displayName `
        -GivenName $employee.FirstName `
        -Surname $employee.LastName `
        -SamAccountName $employee.Username `
        -UserPrincipalName "$($employee.Username)@corp.local" `
        -Path $employeesOU `
        -Department $employee.Department `
        -Title $employee.JobTitle `
        -AccountPassword $temporaryPassword `
        -Enabled $true

    Add-ADGroupMember `
        -Identity "GG_All_Employees" `
        -Members $employee.Username

    if ($departmentGroups.ContainsKey($employee.Department)) {

        $departmentGroup = $departmentGroups[$employee.Department]

        Add-ADGroupMember `
            -Identity $departmentGroup `
            -Members $employee.Username

        Write-Host "Assigned department group: $departmentGroup" -ForegroundColor Cyan
    }
    else {
        Write-Host "WARNING: No department group mapped for $($employee.Department)" -ForegroundColor Yellow
    }

    Write-Host "CREATED: $displayName ($($employee.Username))" -ForegroundColor Green
}