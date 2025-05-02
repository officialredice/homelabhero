# episode_02_dns_dhcp_ca

# 🧵 Episode 02 – DHCP + DNS Server on RHEL

In this episode, you'll build a dedicated DHCP and backup DNS server on a new VM, using Red Hat-based Linux and Hyper-V. This reflects how real-world enterprises separate infrastructure roles for reliability and scalability.

---

## 📦 What You’ll Set Up

- ISC DHCP Server
- DNS Client pointed to FreeIPA DNS
- Static IP with hostname `dhcp.corp.local`

---

## 🧰 Requirements

| Component         | Minimum Specs        |
|------------------|----------------------|
| VM Host          | Hyper-V (Gen 2)      |
| OS ISO           | RHEL 9 / AlmaLinux 9 |
| RAM              | 2 GB                 |
| Disk             | 20–40 GB             |
| Network          | Internal Virtual Switch (same as FreeIPA) |

---

## 🖥️ VM Provisioning (Hyper-V)

1. **Open Hyper-V Manager**
2. **Action → New → Virtual Machine**
   - Name: `dhcp`
   - Generation: **Gen 2**
   - Startup Memory: `2048 MB`
   - Use an **existing virtual switch** (the one connected to `ipa`)
3. **Attach OS ISO**
   - Choose RHEL or AlmaLinux 9 ISO
4. **Create 20–40 GB VHD**
5. **Finish and boot VM**

---

## 🌐 Static IP Setup

Edit network config:

```bash
nmcli con show
nmcli con mod "Wired connection 1" ipv4.addresses 192.168.100.11/24
nmcli con mod "Wired connection 1" ipv4.gateway 192.168.100.1
nmcli con mod "Wired connection 1" ipv4.dns 192.168.100.10
nmcli con mod "Wired connection 1" ipv4.method manual
nmcli con up "Wired connection 1"
```

Set hostname:
```bash
hostnamectl set-hostname dhcp.corp.local
```


📥 Install DHCP Server

Install ISC DHCP server:
```bash
sudo dnf install dhcp-server -y
```

🧾 Configure /etc/dhcp/dhcpd.conf

```bash
default-lease-time 600;
max-lease-time 7200;
authoritative;

subnet 192.168.100.0 netmask 255.255.255.0 {
  range 192.168.100.100 192.168.100.150;
  option routers 192.168.100.1;
  option domain-name-servers 192.168.100.10;
  option domain-name "corp.local";
}

host ipa {
  hardware ethernet 00:11:22:33:44:55; # Replace with actual MAC
  fixed-address 192.168.100.10; # Replace this with actual IP address
}
```

🔄 Enable and Start DHCP Server

```bash
sudo systemctl enable --now dhcpd
sudo systemctl status dhcpd
```

✅ Verify the Setup

On a test client (Ubuntu, RHEL, etc):

```Bash
ip a     # Should get IP from DHCP
ping ipa.corp.local
dig ipa.corp.local
```

🧠 Pro Tips
1. You can set static leases with known MACs.
2. Use this DHCP server to support PXE boot in later episodes.
3. You may also configure bind or dnsmasq as a caching DNS forwarder here later.


