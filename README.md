# LAMP

This playbook will install a dev environment based on **A**pache, **M**ySQL and **P**HP in a multipass Ubuntu 22.04 virtual machine. A CodeIgniter default app will be created with the options specified in the `vars/default.yml` variable file.

Warning : only tested on macos for now.

## Settings

- `mysql_root_password`: the password for the MySQL root account.

If you don't have yet a multipass vm running, try this :

```shell
multipass launch jammy --name lab --cpus 2 --mem 2G --disk 10G
```

## Running this Playbook

Quickstart guide :

### 1. Obtain the playbook

```shell
git clone https://github.com/brahimmachkouri/multipass-amp.git
cd multipass-amp
```

### 2. Change the MySQL password (optionnal)

```shell
nano vars/default.yml
```

```yml
---
mysql_root_password: "superpass"
```

### 3. Rename the main script with the VM name

Suppose your VM is named "lab". Then :
```shell
mv multipass-amp.sh lab
```

The script will find the IP address associated with the vm name.

### 4. Run the Playbook

Run the script you've just renamed :

```shell
./lab
```
