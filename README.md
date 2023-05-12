# macos-libvirt

Run a lightweight + headless VM on macOS using libvirt and QEMU

## Setup

0. Install prerequisites

```
$ brew install libvirt
```

1. Clone this repo to `~/vms`

```bash
$ git clone https://github.com/adwinying/macos-libvirt ~/vms
```

2. Create virtual disk

```bash
$ qemu-img create -f qcow2 workdev.qcow2 64g
```

3. Update configs in XML file as necessary

```xml
  <memory unit='GiB'>4</memory>
  ...
  <vcpu>4</vcpu>
  ...
  <devices>
    <emulator>/path/to/homebrew/bin/qemu-system-aarch64</emulator>
    ...
    <disk type='file' device='disk'>
      <source file='/Users/[user name]/vms/workdev.qcow2' />
    </disk>
    <disk type='file' device='disk'>
      <source file='/path/to/installer.iso' />
    </disk>
  </devices>
```

4. Add domain (VM) to libvirt

```bash
$ virsh define workdev.xml
```

5. Start VM

```bash
$ virsh start workdev
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

## Useful Commands

```bash
# list all libvirt domains
$ virsh list -all

# edit domain config
$ virsh edit [domain name]

# remove domain
$ virsh undefine [domain name]

# restart domain
$ virsh reboot [domain name]

# send shutdown signal
$ virsh shutdown [domain name]

# force shutdown
$ virsh destroy [domain name]
```

## References
- https://wiki.archlinux.org/title/Libvirt
- https://www.naut.ca/blog/2021/12/09/arm64-vm-on-macos-with-libvirt-qemu/
