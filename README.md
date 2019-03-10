# drupal-debian-secure

Drupal secure and fully automatic installation on Debian Stretch.

# Features

- Use Apache mod_security to protect Drupal.
- nginx for proxying
- LetsEncrypt certificate, with automatic renewal without stopping the server.
- PostgreSQL for the database
- AppArmor for system protection
- Fully automatic installation using Drush
- Clean URLs

# Backup of the installation artefacts

This is using the same principle as HomeBox, i.e. storing artefacts of the deployment in the backup folder.

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
