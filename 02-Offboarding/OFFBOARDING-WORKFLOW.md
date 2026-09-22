# Employee Offboarding Workflow

## Overview

The employee offboarding workflow automates the removal of an employee's access from the Active Directory environment when the employee leaves the organization.

The workflow was implemented using PowerShell and Active Directory.

## Offboarding Process

The automation performs the following actions:

1. Accepts the employee username as input.
2. Searches Active Directory for the specified user.
3. Disables the user's account.
4. Removes the user from security groups associated with active employees.
5. Retains the default `Domain Users` membership.
6. Moves the disabled account to the `Disabled Users` organizational unit.
7. Records the operation in an offboarding audit log.

## Active Directory Destination

Disabled users are moved to:

`OU=Disabled Users,DC=corp,DC=local`

## Security Group Handling

The automation removes the user from assigned security groups, including:

- `GG_All_Employees`
- Department-specific groups such as:
  - `GG_IT_Support`
  - `GG_HR`
  - `GG_Finance`

The default `Domain Users` membership is retained.

## Audit Logging

The workflow generates:

`offboarding-log.csv`

The log records:

- Timestamp
- Username
- Action
- Status
- Details

## Validation

The workflow was tested using the lab account:

**Username:** `omar.ali`

The test confirmed that:

- The account was disabled.
- Active employee security groups were removed.
- The account was moved to the `Disabled Users` OU.
- The offboarding operation was recorded in the audit log.

## Error Handling

The workflow was also tested with a non-existent username to verify that an appropriate error was returned when the specified Active Directory user could not be found.

## Evidence

Relevant screenshots are stored in:

`../07-Screenshots/`

- `P1_S16_Offboarding_Automation_Result.png`
- `P1_S16_Offboarding_AD_Verification.png`

## Scope

This implementation is a controlled Active Directory lab demonstrating repeatable employee offboarding operations. It is not intended to represent a production identity-management system.