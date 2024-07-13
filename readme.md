# Setup

Clone the following repositories at the same level as this repository:
```
.
├── AZIR
├── AZVM
├── azullvm
├── azurite-docker
├── azurite-cs
├── azurite-examples
├── azurite-stdlib
```

# Docker
## Build
`docker-compose build`
## Run
`docker-compose run --rm azurite`
## Compiling azurite
`make all | azurite-cs | azullvm | AZIR | AZVM`
# Running azurite
`./build.sh <file.azur> -t target`
targets azullvm and azurir are automatically compiled
