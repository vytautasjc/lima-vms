VM=dev-ubuntu
DATA_DISK_NAME=dev-data
DATA_DISK_SIZE=20GiB

.PHONY: setup create start shell stop delete delete-data

setup:
	limactl disk create $(DATA_DISK_NAME) --size $(DATA_DISK_SIZE) --format raw
	limactl create \
		--name $(VM) \
		--set 'with(.additionalDisks[0]; .name = "$(DATA_DISK_NAME)" | .format = true | .fsType = "ext4")' \
		./$(VM).yaml

create:
	limactl create \
	--name $(VM) \
	--set '.additionalDisks[0] = "$(DATA_DISK_NAME)"' \
	--yes \
	./$(VM).yaml

start:
	limactl disk unlock $(DATA_DISK_NAME)
	limactl start $(VM)

shell:
	limactl shell $(VM)

stop:
	limactl stop -f $(VM)
	limactl disk unlock $(DATA_DISK_NAME)

delete:
	limactl delete $(VM) -f

delete-data:
	limactl disk delete $(DATA_DISK_NAME) -f