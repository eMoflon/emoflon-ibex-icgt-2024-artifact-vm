# eMoflon::IBeX VM - ICGT 2024 Artifact Evaluation

This repository holds the scripts/resources to build the eMoflon VM for the ICGT24 Artefact Evaluation.


## Setup

You have to use a GNU/Linux OS, for example [Debian 11](https://www.debian.org/releases/bullseye/). (Running this on macOS and Windows might be possible, but it isn't tested.)
- Clone this repository.
- Install all dependencies/tools (`wget`, `unzip`, `tar`, `sed`, `virtualbox-7.0`, and `vagrant`) by running the following command:
```
$ ./setup-runner.sh
```
- Build the VM image by running:  
```
$ ./build-vm.sh
```
- The image will be packed/exported as `emoflon.ova` in the repository.

Please notice:
- The system you use to provision the VM image needs at least a few GBs of free RAM. Use >8GB RAM and it should be fine.
- If you use a VM itself to provision the VM image make sure that it supports nested virtualization.
- If you want to update, for example, the PDF file or the workspace projects, update the files placed in [`resources`](./resources/).


## Scripts/Config files

The following scripts and config files are part of this repository:
- [`build-vm.sh`](./build-vm.sh): Wrapper script that builds the complete VM image.
- [`download-base-vm.sh`](./download-base-vm.sh): Downloads the [base eMoflon::IBeX VM image](https://github.com/eMoflon/emoflon-ibex-vm/releases) from the GitHub.
- [`prepare.sh`](./prepare.sh): Extracts the downloaded base VM image and adds it as Vagrant box.
- [`prov.sh`](./prov.sh): Provisioning script that will be used to configure the VM image, e.g., to add projects to the default Eclipse workspace.
- [`setup-runner.sh`](./setup-runner.sh): Installation script to install all dependencies/tools on the runner's system.
- [`Vagrantfile`](./Vagrantfile): Vagrant configuration for the VM provisioning.


## License

This project is licensed under the GNU General Public License v3.0 - see the [LICENSE](LICENSE) file for more details.
