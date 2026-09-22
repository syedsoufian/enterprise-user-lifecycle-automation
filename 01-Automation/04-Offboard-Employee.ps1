Import-Module ActiveDirectory

$username = Read-Host "Enter username to offboard"

$employee = Get-ADUser `
    -Identity $username `
    -Properties MemberOf `
    -ErrorAction SilentlyContinue

if (-not $employee) {
    Write-Host "ERROR: User '$username' was not found." -ForegroundColor Red
    exit
}

$disabledOU = "OU=Disabled Users,DC=corp,DC=local"

Write-Host "Starting offboarding for $username..." -ForegroundColor Cyan

Disable-ADAccount -Identity $username

Write-Host "Account disabled." -ForegroundColor Yellow

$groups = $employee.MemberOf

foreach ($group in $groups) {

    $groupName = (Get-ADGroup -Identity $group).SamAccountName

    if ($groupName -ne "Domain Users") {
        Remove-ADGroupMember `
            -Identity $group `
            -Members $username `
            -Confirm:$false

        Write-Host "Removed from group: $groupName" -ForegroundColor Yellow
    }
}

Move-ADObject `
    -Identity $employee.DistinguishedName `
    -TargetPath $disabledOU

Write-Host "Account moved to Disabled Users OU." -ForegroundColor Yellow

$timestamp = Get-Date -Format "yyyy-MM-dd HH:mm:ss"

[PSCustomObject]@{
    Timestamp = $timestamp
    Username  = $username
    Action    = "Offboarding"
    Status    = "SUCCESS"
    Details   = "Account disabled, access groups removed, and account moved to Disabled Users OU"
} | Export-Csv ".\offboarding-log.csv" -Append -NoTypeInformation

Write-Host ""
Write-Host "OFFBOARDING COMPLETED: $username" -ForegroundColor Green