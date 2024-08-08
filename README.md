<div style="text-align: center">
  <a href="#">
    <img src="https://raw.githubusercontent.com/if-you-want-peace-prepare-for-war/proxmox/master/misc/images/logo.png" height="100px" alt="logo" />
 </a>
</div>
<h1 style="text-align: center">Proxmox VE Helper-Scripts</h1>

<p style="text-align: center">
  <a href="https://tteck.github.io/Proxmox/">Website</a> | 
  <a href="https://github.com/if-you-want-peace-prepare-for-war/proxmox/blob/master/.github/CONTRIBUTING.md">Contribute</a> |
  <a href="https://github.com/if-you-want-peace-prepare-for-war/proxmox/blob/master/USER_SUBMITTED_GUIDES.md">Guides</a> |
  <a href="https://github.com/if-you-want-peace-prepare-for-war/proxmox/blob/master/CHANGELOG.md">Changelog</a> |
  <a href="https://ko-fi.com/X8X37FUGU">Support</a>
</p>

---

> [!WARNING]
Be cautious of copycat or coat-tailing sites that exploit the project's popularity with potentially malicious intent. Please only trust information from https://tteck.github.io/Proxmox/.

These scripts empower users to create a Linux container or virtual machine interactively, providing choices for both simple and advanced configurations. The basic setup adheres to default settings, while the advanced setup gives users the ability to customize these defaults. 

## Usage
To create a new Proxmox VE LXC Client Container, run the command below in the Proxmox VE Shell.
To Update Nginx Proxy Manager, run the same command below (or type update) in the LXC Console.

Replace `ct/installscript.sh` with the actual path and script to use for installation.

```bash
bash -c "$(wget -qLO - https://github.com/if-you-want-peace-prepare-for-war/proxmox/raw/master/ct/installscript.sh)"
```

Options are displayed to users in a dialog box format. Once the user makes their selections, the script collects and validates their input to generate the final configuration for the container or virtual machine.
<p style="text-align: center">
Be cautious and thoroughly evaluate scripts and automation tasks obtained from external sources. <a href="https://github.com/if-you-want-peace-prepare-for-war/proxmox/blob/master/CODE-AUDIT.md">Read more</a>
</p>
<sub>Proxmox® is a registered trademark of Proxmox Server Solutions GmbH.</sub>
