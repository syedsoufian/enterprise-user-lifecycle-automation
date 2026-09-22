# Enterprise User Lifecycle Automation Suite

## Project Overview

The Enterprise User Lifecycle Automation Suite is a Windows Server and Active Directory-based IT automation project designed to automate common employee identity lifecycle tasks.

The project simulates an enterprise IT environment where employee information is maintained in a structured CSV file and PowerShell automation is used to create, configure, validate, and offboard Active Directory user accounts.

## Objectives

- Build a functional Active Directory lab environment.
- Automate employee onboarding using PowerShell.
- Assign users to organization-wide and department-specific security groups.
- Configure employee attributes such as department and job title.
- Automate employee offboarding.
- Disable accounts and remove unnecessary access during offboarding.
- Maintain onboarding and offboarding audit logs.
- Validate employee input data before processing.
- Test domain authentication using automated user accounts.

## Environment

- Windows Server 2025
- Active Directory Domain Services
- PowerShell
- VMware Workstation
- Windows Server domain controller
- Domain-joined client/server VM
- CSV-based employee data

## Active Directory Environment

Domain:

`corp.local`

Domain Controller:

`P1-DC01`

Domain-Joined Machine:

`P1-CLIENT01`

Organizational Units:

- Employees
- Groups
- Disabled Users

Security Groups:

- GG_All_Employees
- GG_IT_Support
- GG_HR
- GG_Finance

## Automation Capabilities

### Employee Onboarding

The automation reads employee records from a CSV file and creates new Active Directory accounts.

The process includes:

1. Reading employee information.
2. Checking whether the account already exists.
3. Creating the Active Directory account.
4. Placing the account in the Employees OU.
5. Setting department and job title attributes.
6. Adding the user to GG_All_Employees.
7. Assigning the appropriate department security group.

### Employee Offboarding

The offboarding automation:

1. Identifies the employee account.
2. Disables the account.
3. Removes the account from applicable security groups.
4. Moves the account to the Disabled Users OU.
5. Records the operation in an offboarding log.

### Logging

The project maintains CSV-based audit logs for onboarding and offboarding operations.

### Input Validation

A dedicated PowerShell validation script checks employee CSV data for required columns and missing values before processing.

## Test Employees

The project was tested using multiple employee records across different departments, including:

- IT
- HR
- Finance

The test environment successfully demonstrated automated account creation, group assignment, offboarding, and domain authentication.

## Project Outcome

The project demonstrates practical experience with:

- Active Directory administration
- Windows Server
- PowerShell automation
- Identity and access management
- User lifecycle management
- Security group management
- Account offboarding
- Audit logging
- IT infrastructure troubleshooting