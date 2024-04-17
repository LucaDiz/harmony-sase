## Project Overview
This Terraform project automates the deployment of a multi-environment setup on Azure, featuring a Linux Ubuntu 18.04 LTS host with a WireGuard connector and a Windows 11 Desktop. The primary goal is to enable Remote Desktop Protocol (RDP) access to the Windows machine through the Harmony Secure Access Service Edge (SASE) solution using the WireGuard connector. This setup ensures secure and efficient remote connectivity, ideal for various operational needs.

### Key Components
- **Ubuntu 18.04 LTS VM**: Hosts the WireGuard connector.
- **Windows 11 Desktop VM**: Configured for remote access via RDP.
- **Harmony SASE**: Utilizes this advanced SASE framework to securely connect to the Windows desktop through the WireGuard tunnel.

### Prerequisites
- **Terraform Initialization**: Ensure Terraform is installed and initialized to orchestrate the infrastructure as code.
- **Azure CLI**: Must be installed to perform `az login` for authenticating to your Azure environment.

### Cross-Platform Compatibility
This Terraform configuration is versatile and with minor modifications can also be adapted for use with Google Cloud Platform (GCP) and Amazon Web Services (AWS).

### Deployment Steps
1. **Connect to the Linux VM**: After deploying Terraform, connect to the Linux machine and execute the provided Harmony SASE Perimeter81 command to register the WireGuard connector with your preferred Point of Presence (PoP).
2. **Access the Windows VM via RDP**: Simply connect via RDP on Azure to perform the initial Windows setup through a straightforward process.

Following these steps, the Windows machine will be securely accessible through the Harmony SASE solution.
---