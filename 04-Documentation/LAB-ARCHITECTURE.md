# Lab Architecture

## 1. Lab Overview

The Enterprise User Lifecycle Automation Suite is built in a virtualized Windows Server lab using VMware Workstation.

The lab contains two virtual machines:

- P1-DC01 — Domain Controller
- P1-CLIENT01 — Domain-joined machine

The environment is configured as a small enterprise-style Active Directory domain.

---

## 2. Virtual Machines

| Machine | Operating System | Role |
|---|---|---|
| P1-DC01 | Windows Server 2025 | Active Directory Domain Controller |
| P1-CLIENT01 | Windows Server 2025 | Domain-joined client/test machine |

---

## 3. Network Configuration

| Component | Configuration |
|---|---|
| Network Type | VMware NAT |
| Domain Controller | 192.168.206.10 |
| Domain-joined Machine | 192.168.206.11 |
| Default Gateway | 192.168.206.2 |
| Active Directory Domain | corp.local |

### DNS Configuration

P1-CLIENT01 uses the domain controller:

```text
192.168.206.10