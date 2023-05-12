# macos-barebones-vm

Run a lightweight + headless VM on macOS using QEMU

## Setup

0. Install QEMU

```
$ brew install qemu

# Disable QEMU security as it's not supported in macOS
echo 'security_driver = "none"' >> /opt/homebrew/etc/libvirt/qemu.conf
echo "dynamic_ownership = 0" >> /opt/homebrew/etc/libvirt/qemu.conf
echo "remember_owner = 0" >> /opt/homebrew/etc/libvirt/qemu.conf
```

1. Clone this repo to `~/vms`

```bash
$ git clone https://github.com/adwinying/macos-libvirt ~/vms
```

2. Create virtual disk

```bash
$ qemu-img create -f qcow2 workdev.qcow2 64G
```

3. Update QEMU command arg if necessary

```bash
  -drive file=/path/to/qcow2/image
  -cdrom /path/to/installer.iso
```

4. Start VM

```bash
$ ./workdev.sh
```

## Usage

- Connect to VM via VNC using [RealVNC Viewer](https://www.realvnc.com/en/connect/download/viewer/) (macOS's native VNC Client does not work!)

```
localhost:5900
```

- Connect to VM via SSH:

```bash
$ ssh -p 2222 [vm user name]@localhost
```

## References
- https://wiki.archlinux.org/title/QEMU
- https://www.naut.ca/blog/2021/12/09/arm64-vm-on-macos-with-libvirt-qemu/
- https://www.sevarg.net/2021/01/09/arm-mac-mini-and-boinc/
