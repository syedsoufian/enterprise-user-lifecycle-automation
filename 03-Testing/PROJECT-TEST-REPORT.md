# Project Test Report

## 1. Test Overview

The Enterprise User Lifecycle Automation Suite was tested within a controlled Windows Server and Active Directory lab environment.

Testing focused on validating user onboarding, group assignment, authentication, logging, offboarding, and CSV input validation.

## 2. Test Environment

### Domain Controller

- Hostname: `P1-DC01`
- Operating System: Windows Server 2025
- Domain: `corp.local`
- IP Address: `192.168.206.10`

### Domain-Joined Test Machine

- Hostname: `P1-CLIENT01`
- Operating System: Windows Server 2025
- IP Address: `192.168.206.11`

## 3. Test Users

| User | Department | Test Purpose |
|---|---|---|
| Aarav Sharma | IT | Existing-user handling |
| Sara Khan | HR | Automated onboarding |
| Omar Ali | Finance | Onboarding and offboarding |
| Zoya Ahmed | Finance | Improved onboarding validation |

## 4. Test Cases

### Test 01 — Employee CSV Import

**Objective:**  
Verify that employee records can be read from the CSV input file.

**Result:** PASSED

The employee CSV was successfully read and existing Active Directory users were detected.

---

### Test 02 — New User Onboarding

**Objective:**  
Verify that a new employee can be automatically created in Active Directory.

**Result:** PASSED

New users were successfully created in the `Employees` OU with the required user attributes.

---

### Test 03 — Department-Based Group Assignment

**Objective:**  
Verify that employees receive the appropriate security group based on their department.

**Result:** PASSED

The automation successfully assigned department-specific groups for IT, HR, and Finance users.

Examples:

- IT → `GG_IT_Support`
- HR → `GG_HR`
- Finance → `GG_Finance`

---

### Test 04 — Duplicate User Handling

**Objective:**  
Verify that existing users are not recreated during repeated automation runs.

**Result:** PASSED

Existing users were detected and skipped safely.

The onboarding log recorded these operations with a `SKIPPED` status.

---

### Test 05 — Onboarding Audit Logging

**Objective:**  
Verify that onboarding operations are recorded in an audit log.

**Result:** PASSED

The automation generated `onboarding-log.csv` containing timestamps, usernames, actions, statuses, and details.

---

### Test 06 — Domain Authentication

**Objective:**  
Verify that automatically provisioned users can authenticate against the domain.

**Result:** PASSED

Automated user authentication was successfully verified on `P1-CLIENT01`.

---

### Test 07 — Employee Offboarding

**Objective:**  
Verify that an employee account can be automatically disabled and removed from active access groups.

**Result:** PASSED

The `omar.ali` account was:

- Disabled
- Removed from active employee security groups
- Moved to the `Disabled Users` OU
- Recorded in the offboarding audit log

---

### Test 08 — Invalid Offboarding Username

**Objective:**  
Verify that the offboarding workflow handles a username that does not exist in Active Directory.

**Result:** PASSED

The workflow returned an error indicating that the specified user could not be found.

---

### Test 09 — Improved Onboarding Automation

**Objective:**  
Verify the improved onboarding implementation using centralized department-to-group mapping.

**Result:** PASSED

The improved automation successfully processed existing users and created a new Finance user with the appropriate group assignment.

---

### Test 10 — Employee CSV Validation

**Objective:**  
Verify that the employee CSV contains the required columns and valid values.

**Result:** PASSED

The validation script confirmed that the required fields were present and that the test employee records passed validation.

## 5. Test Evidence

Screenshots supporting the validation are stored in:

`../07-Screenshots/`

Key evidence includes:

- `P1_S13_Automated_User_Onboarding.png`
- `P1_S14_Onboarding_Audit_Log.png`
- `P1_S15_Successful_Onboarding_Log.png`
- `P1_S16_Offboarding_Automation_Result.png`
- `P1_S16_Offboarding_AD_Verification.png`
- `P1_S17_Automated_User_Authentication.png`
- `P1_S18_Improved_Onboarding_Test.png`
- `P1_S19_CSV_Validation_Passed.png`

## 6. Testing Summary

| Area | Result |
|---|---|
| CSV import | PASSED |
| User onboarding | PASSED |
| Department group assignment | PASSED |
| Duplicate-user handling | PASSED |
| Onboarding logging | PASSED |
| Domain authentication | PASSED |
| Employee offboarding | PASSED |
| Invalid-user handling | PASSED |
| Improved onboarding | PASSED |
| CSV validation | PASSED |

## 7. Final Validation Status

**PROJECT VALIDATION: PASSED**

The implemented lab workflows successfully demonstrated repeatable employee onboarding and offboarding operations using PowerShell and Active Directory.

The testing was performed in a controlled lab environment and does not represent production deployment validation.