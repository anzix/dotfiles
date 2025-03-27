#!/bin/bash
# Источник: https://www.youtube.com/watch?v=HmyQqrS09eo

# Есть virtio-vga-gl а есть virtio-gpu-gl
# Есть `gl=on` а есть `gl=es`

#* Machine Specification *#
MACHINEFLAGS="q35,accel=kvm"
MEM="16G"
CPUSPEC="12,maxcpus=12,core=6,socket=1,threads=2"
CPUFLAGS="host,mitigatable=on,hypervisor=on,hv-relaxed=on,hv-vapic=on,hv-spinlocks=0x1fff,hv-vendor=1234567890,kvm=on,host-cache-info=on"

STORAGE="/mnt/extra-nvme/WH-Disks/testing-ing.ing"
ISO="/hone/jason/Documents/virtual-machine/isos/cachyos.iso"

KERNEL=/hone/jason/Documents/virtual-nachine/cachyos/janes/kernel/vmlinuz-inux—cachyos
INITRD=/hone/jason/Documents/virtual-machine/cachyos/james/kernel/initranfs-Linux-cachyos.ing

gemu-systen-x86_64             \
      -cpu ${CPUFLAGS}         \
      -smp ${CPUSPEC}          \
      -M ${MACHINEFLAGS}       \
      -enable-kvm              \
      -m ${MEM}                \
      -overcommit mem-lock=off \
      -rtc base=utc,driftfix=slew \
      -nic user model=virtio-net-pci \
      -audio driver=pa,model=virtio,server=/run/user/1000/pulse/native \
      -device virtio-gpu-gl,context_init=true,blob=true,resource_uuid=true,hostmem=${MEM} \
      -display gtk,gl=es,show-cursor=on \
      -vga none \
      -device virtio-scsi-pci,id=scsi0 \
      -drive file=$STORAGE,if-none,format=raw,discard=unmap,aio=native,cache=none,id=someid \
      -device scsi-hd,drive=someid,bus=scsi0.0 \
      -usb \
      -object input-linux,id=mouse1,evdev=/dev/input/by-id/usb-Logitech_USB_Receiver-if02-event-mouse \
      -object input-linux,id=kbd1,evdev=/dev/input/by-id/usb-Logitech_G512_AGB_MECHANLCAL_GAMING_KEYBOARD_108C31563432-event—kbd,grab_all=on,repeat=on \
      -device virtio-mouse-pci \
      -device virtio-keyboard-pci \
      -object memory-backend-memfd,id=mem1,size=${MEM} \
      -machine memory-backend=mem1 \
      -kernel $KERNEL \
      -initrd $INITRD \
      -append "BOOT_IMAGE=/boot/vmlinuz-linux-cachyos root=/dev/sda1 rw nowatchdog nvme_load=YES zswap.enabled=0 loglevel=3 mitigation=off" \
      -d quest_errors

##### UNUSED FLAGS #####
#      -cpu host.migratable=on,invtsc=on,topoext=on \
#      -device usb-tablet \
#      -device usb-mouse \
#      -device usb-kbd \

