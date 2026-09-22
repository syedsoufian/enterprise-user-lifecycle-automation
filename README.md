# Enterprise User Lifecycle Automation Suite

A PowerShell and Active Directory automation project designed to streamline employee onboarding and offboarding operations in a controlled IT support lab environment.

---

## Project Overview

Managing employee accounts manually can lead to repetitive administrative work, inconsistent access assignment, and increased risk of access remaining active after an employee leaves an organization.

This project demonstrates a repeatable employee identity lifecycle workflow using Windows Server, Active Directory Domain Services, PowerShell automation, structured CSV input, and audit logging.

The solution automates key onboarding and offboarding tasks while providing validation and operational logging.

---

## Objectives

The project was designed to:

- Automate employee account creation in Active Directory
- Assign department-based security groups
- Populate employee attributes such as department and job title
- Prevent duplicate user creation during repeated runs
- Automate employee offboarding
- Disable accounts and remove active access during offboarding
- Move disabled accounts into a dedicated organizational unit
- Maintain onboarding and offboarding audit logs
- Validate employee CSV input before processing
- Verify domain authentication using a domain-joined test machine

---

## Solution Architecture

The solution uses a simple identity lifecycle automation flow:

```text
Employee CSV
     |
     v
PowerShell Automation
     |
     v
Active Directory Domain Controller
     |
     +---- User Accounts
     |
     +---- Organizational Units
     |
     +---- Security Groups
     |
     v
Domain-Joined Test Machine
```

The complete architecture diagram is available in:

`06-Diagrams/`

---

## Lab Environment

### Domain Controller

- Hostname: `P1-DC01`
- Operating System: Windows Server 2025
- Domain: `corp.local`
- IP Address: `192.168.206.10`
- Role: Active Directory Domain Controller

### Domain-Joined Test Machine

- Hostname: `P1-CLIENT01`
- Operating System: Windows Server 2025
- IP Address: `192.168.206.11`
- Role: Domain-joined test machine

### Network

- VMware NAT network
- Domain Controller and test machine configured with static IP addresses
- DNS configured through the Active Directory domain controller

---

## Active Directory Structure

The lab environment uses the following organizational units:

```text
corp.local
│
├── Employees
├── Groups
└── Disabled Users
```

Security groups include:

- `GG_All_Employees`
- `GG_IT_Support`
- `GG_HR`
- `GG_Finance`

---

## Employee Onboarding

The onboarding workflow reads employee information from a CSV file and automates account provisioning.

### Input

Example employee fields:

```text
FirstName
LastName
Username
Department
JobTitle
```

### Automated Actions

The onboarding automation:

1. Reads employee records from the CSV file
2. Checks whether the account already exists
3. Creates new users in the `Employees` OU
4. Sets the user's UPN
5. Applies department and job-title attributes
6. Adds the user to `GG_All_Employees`
7. Assigns the appropriate department security group
8. Records the operation in the onboarding log

### Department Mapping

| Department | Security Group |
|---|---|
| IT | `GG_IT_Support` |
| HR | `GG_HR` |
| Finance | `GG_Finance` |

---

## Employee Offboarding

The offboarding workflow automates the removal of active employee access.

The process:

1. Identifies the employee account
2. Disables the account
3. Removes active employee security group memberships
4. Retains the default `Domain Users` membership
5. Moves the account to the `Disabled Users` OU
6. Records the operation in the offboarding audit log

This provides a repeatable approach for handling employee departures within the lab environment.

---

## Automation Components

The project contains multiple PowerShell automation scripts covering different stages of the workflow:

| Script | Purpose |
|---|---|
| `01-Test-Employee-Import.ps1` | Tests employee CSV import and account detection |
| `02-Onboard-Employees.ps1` | Creates and configures Active Directory users |
| `03-Onboard-Employees-With-Logging.ps1` | Adds onboarding audit logging |
| `04-Offboard-Employees.ps1` | Automates employee offboarding |
| `05-Onboard-Employees-Improved.ps1` | Improved onboarding implementation using centralized department mapping |
| `06-Validate-Employee-CSV.ps1` | Validates required CSV fields and employee records |

---

## Logging and Audit Trail

The project generates CSV-based audit logs for operational tracking.

### Onboarding Log

`onboarding-log.csv`

Records:

- Timestamp
- Username
- Action
- Status
- Details

### Offboarding Log

`offboarding-log.csv`

Records:

- Timestamp
- Username
- Action
- Status
- Details

These logs provide evidence of automation execution and help support basic operational auditing.

---

## Testing and Validation

The project was validated through multiple test scenarios.

Testing included:

- Employee CSV import
- New user creation
- Department-based group assignment
- Duplicate-user handling
- Onboarding audit logging
- Domain authentication
- Employee offboarding
- Invalid-user handling
- Improved onboarding automation
- CSV validation

Test users included:

- Aarav Sharma — IT
- Sara Khan — HR
- Omar Ali — Finance
- Zoya Ahmed — Finance

The detailed test report is available in:

`03-Testing/PROJECT-TEST-REPORT.md`

---

## Project Evidence

Selected screenshots demonstrating the implementation are available in:

`05-Screenshots/`

The screenshots cover key milestones such as:

- Active Directory configuration
- Organizational unit and group structure
- Automated onboarding
- Audit logging
- Offboarding
- Domain authentication
- Improved automation
- CSV validation

---

## Technologies Used

- Windows Server 2025
- Active Directory Domain Services
- PowerShell
- VMware Workstation
- CSV
- Active Directory Users and Computers
- Windows networking and DNS

---

## Repository Structure

```text
Enterprise-User-Lifecycle-Automation
│
├── README.md
│
├── 01-Automation
│   ├── PowerShell automation scripts
│   ├── Employee CSV input
│   └── Audit logs
│
├── 02-Offboarding
│   └── Offboarding workflow documentation
│
├── 03-Testing
│   └── Project test report
│
├── 04-Documentation
│   ├── Project overview
│   └── Lab architecture
│
├── 05-Screenshots
│   └── Project evidence
│
└── 06-Diagrams
    └── Architecture diagram
```

---

## Key Outcomes

The project demonstrates a repeatable approach to employee identity lifecycle management within an Active Directory environment.

The implemented solution successfully demonstrates:

- Automated employee provisioning
- Department-based access assignment
- Duplicate-user handling
- Automated employee offboarding
- Account disabling and access removal
- Organizational unit management
- CSV input validation
- Audit logging
- Domain authentication testing

---

## Production Considerations

This project is a controlled lab implementation intended for learning and portfolio demonstration.

A production implementation would require additional controls such as:

- Secure credential management
- Privileged access controls
- Formal approval workflows
- Centralized logging and monitoring
- Integration with enterprise identity platforms
- Additional security validation
- Change management and rollback procedures

The project does not represent a production deployment.

---

## Documentation

Additional project documentation is available in:

`04-Documentation/`

This includes the project overview and lab architecture documentation.

---

## Author

**Soufian Syed**

IT Support / Systems Administration Project
