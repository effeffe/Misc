#!/usr/bin/bash
TOGGLE=/tmp/.toggle_gpu
if [ ! -e $TOGGLE ]; then
    touch $TOGGLE
    sudo su -c "cp /scripts/gpu_probe/enable_gpu.rules /etc/udev/rules.d/80-nvidia-pm.rules"
    sleep 0.3
    sudo su -c "udevadm control --reload && udevadm trigger"
	sleep 1
	sudo su -c "echo 1 > /sys/bus/pci/rescan"
	sleep 2
    systemctl --user restart pulseaudio.service
else
    sudo su -c "cp /scripts/gpu_probe/disable_gpu.rules /etc/udev/rules.d/80-nvidia-pm.rules"
	sleep 0.3
    sudo su -c "udevadm control --reload && udevadm trigger"
	sleep 1
    sudo su -c "echo 1 > /sys/bus/pci/devices/0000:01:00.1/remove"
    sudo su -c "echo 1 > /sys/bus/pci/rescan"
	sleep 2
    systemctl --user restart pulseaudio.service
fi
