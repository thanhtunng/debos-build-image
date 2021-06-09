# Prepare
- Clone source with submodules:
```
git clone --recurse-submodules https://github.com/thanhtunng/debos-build-image.git
```
# Build debos image
```
cd submodules/debos
docker build -f docker/Dockerfile -t godebos/debos .
```
# Build debian image
- Build image:
```
make build_qemu_img
```
- As default using uml backend, can change to kvm:
```
make build_qemu_img BACKEND=kvm
```
- Run image:
```
make run_qemu_img
```


