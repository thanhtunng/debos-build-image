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
- As default using kvm backend, can change to uml:
```
make build_qemu_img BACKEND=uml
```
- Run image:
```
make run_qemu_img
```


