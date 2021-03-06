<?php
//
// database access settings in php format
// automatically generated from /etc/dbconfig-common/drupal7.conf
// by /usr/sbin/dbconfig-generate-include
//
// by default this file is managed via ucf, so you shouldn't have to
// worry about manual changes being silently discarded.  *however*,
// you'll probably also want to edit the configuration file mentioned
// above too.
//
// This file ends up being too verbose because the semantics for the
// options used in it differ per database type (and dbconfig's
// templating system does not handle conditionals); should you choose
// not to use debconf/dbconfig to handle Drupal's database
// configuration, you will probably prefer to discard $dbs, and store
// the declarations straight into $databases.

$dbs['pgsql'] = array(
    'driver' => 'pgsql',
    'database' => 'drupal',
    'username' => 'drupal',
    'password' => '{{ drupal_db_password }}',
    'host' => 'localhost',
    'port' => '5432',
    'prefix' => ''
);

$databases['default']['default'] = $dbs['pgsql'];
