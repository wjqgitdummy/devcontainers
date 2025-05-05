# Docker Images for Dev Env Setup

## Key Features
* Contains various dev setups
* Images has dependencies
* Uses Github Action to automate build and shipment
* Supports push multiple registries
    * Primary: ghcr.io
    * Secondary: specified by action secrets and variables
        * `DOCKER_REGISTRY`
        * `DOCKER_USERNAME`
        * `DOCKER_PASSWORD` 
* Supports multi-arch build
