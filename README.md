# drupal-debian-secure

Drupal secure and fully automatic installation on Debian Stretch.

# Features

- Use Debian packages only. Drush is installed through composer, but can be deinstalled once the 
  installation is done.
- Use Apache mod_security to protect Drupal.
- Use nginx for proxying.
- Create LetsEncrypt certificate, with automatic renewal without stopping the server.
- PostgreSQL for the database.
- AppArmor for system protection.
- Fully automatic installation using Drush.
- Clean URLs.

# Installation

## Clone the repository

```sh

git clone git@github.com:progmaticltd/drupal-debian-secure.git

```

## Customize configuration

```sh

cd drupal-debian-secure/config
cp hosts-example.yml hosts.yml
cp system-example.yml system.yml

```

Host file content

```yaml
---
# hosts configuration sample

all:
  hosts:
    homebox:
      ansible_host: 12.34.56.78
      ansible_user: root
      ansible_port: 22

```

System file content

```yaml

---

###############################################################################
# Domain and hostname information
network:
  domain: sample.do
  hostname: blog.sample.do

##############################################################################
# Extra security values
security:
  auto_update: true
  app_armor: true
  mod_security:
    install: true

###############################################################################
# Drupal settings
drupal:
  subdomain: blog
  site_name: My wonderful life

###############################################################################
# System related
system:
  release: stretch
  ssl: letsencrypt
  devel: false
  debug: true

```

## Run the ansible script

```sh

cd drupal-debian-secure/install
ansible-playbook -vv -i ../config/hosts.yml playbooks/main.yml

```

# Backup of the installation artefacts

This is using the same principle as HomeBox. Once the Ansible script is run,
artefacts of the deployment are stored in the backup folder:

- Passwords are generated automatically, and stored on the system that ran the Ansible scripts.
- LetsEncrypt certificates are stored and can be re-deployed without requesting new ones, when valid.

## Backup content

| File                                     | Content                          |
|------------------------------------------|----------------------------------|
| backup/\<domain\>/certificates           | LetsEncrypt certificates backup  |
| backup/\<domain\>/drupal/admin.pwd       | Drupal administrator password    |
| backup/\<domain\>/postgresSQL/drupal.pwd | Drupal database password         |

# Notes

This is developed as part of the HomeBox project, but not integrated in the main HomeBox repository.
Some of the roles are copied from HomeBox, especially AppArmor activation and letsencrypt certificates creation.

There are a lot of checks to do before integrating this repository into Homebox, if it will.

# Links

- Homebox: https://github.com/progmaticltd/homebox
- Drupal: https://www.drupal.org/
- Drush: https://github.com/drush-ops/drush
- Apache mod_security: https://modsecurity.org/
