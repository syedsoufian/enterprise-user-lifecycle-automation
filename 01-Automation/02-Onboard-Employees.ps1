Import-Module ActiveDirectory

$employees = Import-Csv ".\employees.csv"

$employeesOU = "OU=Employees,DC=corp,DC=local"

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

    switch ($employee.Department) {

        "IT" {
            Add-ADGroupMember -Identity "GG_IT_Support" -Members $employee.Username
        }

        "HR" {
            Add-ADGroupMember -Identity "GG_HR" -Members $employee.Username
        }

        "Finance" {
            Add-ADGroupMember -Identity "GG_Finance" -Members $employee.Username
        }
    }

    Write-Host "CREATED: $displayName ($($employee.Username))" -ForegroundColor Green
}