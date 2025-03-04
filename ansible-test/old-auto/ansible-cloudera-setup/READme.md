# Ansible Cloudera Setup

This repository contains an Ansible playbook and associated roles for setting up a Cloudera environment. It includes roles for installing Cloudera Manager, Cloudera PVC Base, Kerberos, AutoTLS, and Nginx for serving a private repository. It also sets up integration with Kerberos and AutoTLS.

## Directory Structure

- `roles/`: Contains Ansible roles for various components.
  - `cloudera_manager/`: Role for installing and configuring Cloudera Manager.
  - `cloudera_pvc_base/`: Role for installing and configuring Cloudera PVC Base.
  - `kerberos/`: Role for installing and configuring Kerberos.
  - `autotls/`: Role for configuring AutoTLS.
  - `private_repo/`: Role for configuring a private repository.
  - `nginx/`: Role for setting up Nginx to serve the private repository.
- `playbook.yml`: The main playbook that applies the roles to the target hosts.
- `ansible.cfg`: Configuration file for Ansible.

## Prerequisites

- Ansible installed on the control machine.
- Access to target machines with SSH.
- Root privileges or sudo access on target machines.
- Internet access to download required packages.

## Usage

### 1. Clone the Repository

```bash
git clone https://your-repository-url/ansible-cloudera-setup.git
cd ansible-cloudera-setup

### Summary

- The `ansible.cfg` file sets up default Ansible configurations, such as inventory location, roles path, and logging.
- The `README.md` file explains the purpose of the playbook, how to configure it, and how to run it.

Ensure to replace placeholders (like `your-repository-url`) with your actual values and adjust paths and settings as per your environment.
