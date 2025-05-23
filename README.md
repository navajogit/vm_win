### **Last update: 28.04.2025**

## How to add 3 basic shortcuts to windows similar to gnome:

Run this script command in powershell with administrator privlages:

   ```powershell
   irm https://raw.githubusercontent.com/navajogit/vm_win/refs/heads/main/shortcuts.ps1 | iex
   ```
This script will:
### Change basic shortcuts to work similar as in gnome:
   - **Win+q** shortcut to work like **alt+f4** instead of opening the Search feature
   - **Win+tab** shortcut to work like **alt+tab** 
   - **Win+f** shortcut will run the file explorer

---

## Change wallpaper in unregistred Windows in QEMU VM enviroment or native instalation:
**Workaround for Windows Restriction on Wallpaper Change**

Run this script command in powershell with administrator privlages:

   ```powershell
   irm https://raw.githubusercontent.com/navajogit/vm_win/refs/heads/main/wallpapers.ps1 | iex
   ```
---

## How to Install essential Windows packages for QEMU VM (+gnomeboxes) enviroment:

Run this script command in powershell with administrator privlages:

   ```powershell
   irm https://raw.githubusercontent.com/navajogit/vm_win/refs/heads/main/startup.ps1 | iex
   ```
This script will:

### 1. Propose to install all / specific packages:

- **Portmaster Firewall**:
  - Portmaster is a firewall that helps protect your system's privacy and security by blocking unwanted connections and apps. It enhances protection against online threats and allows monitoring of network activity.
  - **Note**: Portmaster may require some knowledge of data flow configuration in your local network to ensure that peripherals such as printers and other devices function correctly.

- **Windscribe VPN**:
  - Windscribe is a VPN that encrypts your internet connection, hides your IP address, and allows access to geographically restricted content. It also blocks ads and trackers, increasing your online privacy.

- **Brave Browser**:
  - Brave is a browser that automatically blocks ads and trackers, providing better privacy and security online. It also allows supporting content creators through a payment system based on BAT tokens.

- **Spice-guest-tools**:
  - Spice-guest-tools are utilities for virtual machines that improve graphics quality and allow better screen resolution scaling, making the use of virtual machines more comfortable.

- **Spice-webdavd**:
  - Spice-webdavd is a WebDAV server that enables remote access to files between virtual machines and other devices on the network. It's useful for data exchange between systems.

- **ClamAV Antivirus**:
  - ClamAV is a free antivirus program that protects against viruses and other online threats. It regularly updates its databases to detect new threats.

- **Tor Browser**:
  - Tor Browser allows for anonymous browsing by encrypting and routing traffic through the Tor network. It provides secure internet surfing while preserving privacy and enabling access to blocked content.

### 2. Propose to install Chris Titus Tech's Windows Utility

- **Chris Titus Tech's Windows Utility** is a comprehensive PowerShell-based tool designed to streamline and optimize Windows systems. It offers a range of features to enhance system performance and manageability:

  - **Program Installation**: Install multiple programs with a single click, simplifying the setup process.
  
  - **Tweaks**: Apply various system optimizations, including disabling telemetry, removing unwanted background services, and configuring system settings for improved performance.
  
  - **Config**: Access legacy Windows control panels and configure system settings to suit your preferences.
  
  - **Updates**: Adjust Windows Update settings to install only security updates or disable updates altogether, providing greater control over system updates.
  
  - **Microwin**: Create a minimal Windows ISO with the utility pre-installed, ideal for fresh installations.

**Note**: To run the utility natively, open PowerShell as Administrator and execute the following command:
```powershell
irm https://christitus.com/win | iex
```

### 3. Available additional files to download:

- **VeraCryptSetup 1.26.20.exe**  
  - A disk encryption software that provides on-the-fly encryption for your files, folders, or entire drives. It helps to protect sensitive data with strong encryption algorithms.  
  **Latest Version**: 1.26.20, includes the latest security improvements and bug fixes.
  
- **Git-2.49.0-64-bit.exe**  
  - A version control system that allows multiple developers to collaborate on code by tracking changes and managing project histories. Git is widely used in software development.  
  **Latest Version**: 2.49.0, includes new features, optimizations, and bug fixes.

- **AESCrypt_v310_x64.zip**  (web archive) 
  - A file encryption tool based on the Advanced Encryption Standard (AES). It enables secure encryption of files and folders using strong encryption techniques.  
  **Note**: This is an older version that does not require a subscription, but it may lack some features found in the latest versions and might not be fully compatible with the newest updates or functionalities.

- **AESCrypt_console_v310_x64.zip**  (web archive) 
  - The console (command-line) version of AESCrypt, providing the same AES file encryption capabilities, but accessible via terminal or command prompt for automation and batch operations.  
  **Note**: This is an older version that does not require a subscription, but it may lack some features found in the latest versions and might not be fully compatible with the newest updates or functionalities.

---

## What is Ventoy? (SCRIPT AT WORK - DO NOT RUN AT PRESENT)

Ventoy is an open-source tool designed to create bootable USB drives. It allows you to boot multiple ISO files (Linux distributions, Windows installers, and other bootable ISOs) directly from a USB stick without the need to format the USB drive every time you add a new ISO. Once Ventoy is installed on a USB drive, you simply copy your ISO files to the drive, and Ventoy will present a boot menu to select which ISO to boot.

### How to Install Ventoy on a USB Drive using PowerShell

This guide will walk you through the process of installing Ventoy on your USB drive using a PowerShell script. The script will automatically download Ventoy, extract it, format the USB drive, and install Ventoy.

### Prerequisites:
1. A Windows PC with PowerShell.
2. A USB drive that you want to install Ventoy on.
3. A working internet connection to download the Ventoy package.

#### Steps:

1. **Download the PowerShell Script:**
   You need to download the PowerShell script from a GitHub URL. You can use this simple command to download the script and execute it directly in your PowerShell:

   ```powershell
   irm https://raw.githubusercontent.com/navajogit/vm_win/refs/heads/main/ventoy.ps1 | iex
   ```
2. Replace the URL with the raw URL to the PowerShell script on GitHub.

3. Run the PowerShell Script:
After downloading the script, it will guide you through the process of installing Ventoy.

**What the script does:**

- Downloads the Ventoy installation package from the official website.
- Extracts the package to a folder.
- Detects available USB drives.
- Asks you to select the USB drive you want to install Ventoy on.
- Formats the USB drive (all data will be lost).
- Installs Ventoy on the USB drive.

#### Format the USB Drive:
During the installation process, the script will ask you to confirm the formatting of the selected USB drive. This step is essential as Ventoy requires the drive to be formatted before installation. Ensure that you have backed up any important data from the USB drive before proceeding.

#### Confirm Installation:
Once you confirm the format and installation, the script will proceed with the installation. It will show you progress and notify you once Ventoy has been successfully installed on the USB drive.

#### Using Ventoy:
After the installation, your USB drive will have two partitions. The first partition is where you will copy your ISO files. Simply drag and drop your ISO files to the drive. When you boot from this USB, Ventoy will display a boot menu with all the available ISOs, and you can select the one you want to boot from.

#### Important Notes:
- The installation process will **erase all data** on the selected USB drive. Make sure to back up any important files before proceeding.
- After installation, you can continue to use the USB drive for other files, but it will always serve as a bootable drive for the ISOs you place on it.
- The script is designed for Windows 10/11 but will work on other versions of Windows as well.

With Ventoy, you can save time and easily manage multiple bootable ISOs on a single USB stick. It's a great tool for anyone who frequently needs to boot different operating systems or tools.
