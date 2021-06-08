build_qemu_img:
	docker run --rm --interactive --tty \
		--user $(shell id -u) --workdir /recipes \
		--mount "type=bind,source=$(shell pwd),destination=/recipes" \
		--mount "type=bind,source=/dev/shm,destination=/dev/shm" \
		--security-opt label=disable godebos/debos \
		--print-recipe \
		--fakemachine-backend=uml \
		qemu.yaml

run_qemu_img:
	qemu-system-x86_64 \
		-m 1G \
		-device virtio-scsi-pci \
		-device scsi-hd,drive=hd0 \
		-kernel vmlinuz-4.19.0-16-amd64 \
		-initrd initrd.img-4.19.0-16-amd64 \
		-append "root=/dev/sda1 console=ttyS0,115200" \
		-blockdev driver=file,node-name=hd0,filename=debian-buster-amd64-ext4.img \
		-device e1000,netdev=net0 \
		-netdev user,hostfwd=tcp:127.0.0.1:5555-:22,id=net0,hostfwd=tcp:127.0.0.1:2159-:2159 \
		-nographic -serial mon:stdio
