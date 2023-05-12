#!/bin/bash

set -eux

CWD=$(dirname $0)

args=(
  # set emulate machine type
  -machine virt

  # use macOS hypervisor framework
  -accel hvf

  # emulate host CPU
  -cpu host

  # set VM CPU count
  -smp cpus=4

  # set VM RAM
  -m 4096

  # set BIOS/EFI firmware
  -bios $CWD/QEMU_EFI.fd

  # USB Bus
  -device qemu-xhci

  # USB pointer?
  -device usb-tablet

  # USB keyboard
  -device usb-kbd

  # GPU; Without this GUI will look like @$$
  -device virtio-gpu-pci

  # VM disk
  -drive file=$CWD/workdev.qcow2,if=virtio,cache=writethrough

  # Live CD
  -cdrom $CWD/nixos-minimal-22.11.4091.a08e061a4ee-aarch64-linux.iso

  # Output VM display to VNC
  -display vnc=:0

  # Output VM display to stdio
  # -serial stdio

  # Output VM display in a Graphical window
  # -display cocoa

  # Show QEMU monitor console in stdio
  -monitor stdio

  # Enable user networking and forward port 2222 to VM port 22
  -netdev user,id=net0,hostfwd=tcp::2222-:22
  -device virtio-net-pci,netdev=net0

  # Set VM time
  -rtc base=localtime

  # Keyboard Layout
  -k ja
)

qemu-system-aarch64 "${args[@]}"
