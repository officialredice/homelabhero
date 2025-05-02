# episode_01_freeipa_setup
# Episode 01 — Identity Management with FreeIPA

In this episode, we set up a centralized Identity Management (IdM) system using **FreeIPA** — the open-source alternative to Active Directory. It will act as our LDAP directory, DNS server, and certificate authority.

---

## 🧠 What You’ll Learn

- What FreeIPA is and why it matters in corporate networks
- How to install FreeIPA Server on RHEL
- How to configure DNS and realm settings
- How to join clients to the FreeIPA domain

---

## 🛠️ Prerequisites

- Virtualization platform: Hyper-V, VirtualBox, Proxmox, etc.
- A RHEL 9 VM (4GB RAM minimum, static IP recommended)
- Internet access during installation
- Optional: Another Linux VM to join as a client later

---

## 🧱 Network Setup

| Component       | Value            |
|----------------|------------------|
| Hostname       | ipa.corp.local   |
| Domain         | corp.local       |
| Realm          | CORP.LOCAL       |
| IP Address     | 192.168.100.10   |
| DNS Forwarder  | 8.8.8.8 (Google) |

---

## 🧰 Installation Steps

1. **Update system & set hostname**

```bash
sudo dnf update -y
sudo hostnamectl set-hostname ipa.corp.local


2. Install FreeIPA server packages

sudo dnf install -y ipa-server ipa-server-dns

3. Run the installer

sudo ipa-server-install --setup-dns

Use the following values when prompted:

Realm: CORP.LOCAL

Domain: corp.local

Directory Manager password: (set one)

IPA Admin password: (set a different one)

DNS Forwarder: 8.8.8.8

Configure reverse zone: Yes

Configure chrony/NTP: Yes (use default)

4. Open necessary ports (firewalld)

sudo firewall-cmd --add-service=freeipa-ldap --permanent
sudo firewall-cmd --add-service=freeipa-ldaps --permanent
sudo firewall-cmd --add-service=dns --permanent
sudo firewall-cmd --reload

5. Verify the installation
kinit admin
ipa user-find

