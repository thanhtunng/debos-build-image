###
- Build image:
```
host$ make build_img_amd
```
- As default using uml backend, can change to kvm:
```
host$ make build_img_amd BACKEND=kvm
```
- Run image:
```
host$ make run_img_amd
```
