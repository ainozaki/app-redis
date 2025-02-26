kraft(){
	kraft run -b virbr1 "netdev.ipv4_addr=172.44.0.2 netdev.ipv4_gw_addr=172.44.0.1 netdev.ipv4_subnet_mask=255.255.255.0 --"
}

qemu(){
	sudo qemu-system-x86_64 \
		-fsdev local,id=myid,path=$(pwd)/fs0,security_model=none \
		-device virtio-9p-pci,fsdev=myid,mount_tag=fs0,disable-modern=on,disable-legacy=off \
		-netdev bridge,id=en0,br=virbr1 \
		-device virtio-net-pci,netdev=en0 \
		-kernel "build/redis_kvm-x86_64" \
		-append "netdev.ipv4_addr=172.44.0.2 netdev.ipv4_gw_addr=172.44.0.1 netdev.ipv4_subnet_mask=255.255.255.0 -- /redis.conf" \
		-cpu host \
		-enable-kvm \
		-nographic
}

gdb(){
	sudo qemu-system-x86_64 \
		-s \
		-fsdev local,id=myid,path=$(pwd)/fs0,security_model=none \
		-device virtio-9p-pci,fsdev=myid,mount_tag=fs0,disable-modern=on,disable-legacy=off \
		-netdev bridge,id=en0,br=virbr1 \
		-device virtio-net-pci,netdev=en0 \
		-kernel "build/redis_kvm-x86_64.dbg" \
		-append "netdev.ipv4_addr=172.44.0.2 netdev.ipv4_gw_addr=172.44.0.1 netdev.ipv4_subnet_mask=255.255.255.0 -- /redis.conf" \
		-cpu host \
		-enable-kvm \
		-nographic
}

eval $1
