<?php
$CONFIG = array (
  'passwordsalt' => 'SOME_SALT',
  'secret' => 'SOME_SECRET',
  'trusted_domains' => 
  array (
    0 => 'cloud.example.tld',
  ),
  'overwrite.cli.url' => 'https://cloud.example.tld',
  'dbtype' => 'pgsql',
  'version' => '14.0.3.0',
  'dbname' => 'nextcloud',
  'dbhost' => 'pg',
  'dbtableprefix' => 'PREFIX_',
  'dbuser' => 'DBUSER',
  'dbpassword' => 'DBPW',
  'datadirectory' => '/var/www/html/data',
  'installed' => true,
  'maintenance' => false,
  'debug' => false,
  'logtimezone' => 'UTC',
  'loglevel' => 2,
  'log_query' => true,
  'log_rotate_size' => '20971520',
  'log.condition' => 
  array (
    'users' => 
    array (
      0 => 'USER',
    ),
    'apps' => 
    array (
      0 => 'files',
      1 => 'files_external',
    ),
  ),
  'mail_smtpmode' => 'smtp',
  'mail_smtpdebug' => true,
  'mail_from_address' => 'SENDERADDRESS',
  'mail_domain' => 'example.tld',
  'mail_smtpauthtype' => 'LOGIN',
  'mail_smtpauth' => 1,
  'mail_smtphost' => 'mail.example.tld',
  'mail_smtpport' => '465',
  'mail_smtpname' => 'nextcloud@example.tld',
  'mail_smtppassword' => 'MAILPW',
  'mail_smtpsecure' => 'ssl',
  'memcache.local' => '\\OC\\Memcache\\APCu',
  'memcache.distributed' => '\\OC\\Memcache\\Redis',
  'memcache.locking' => '\\OC\\Memcache\\Redis',
  'redis' => 
  array (
    'host' => 'redis',
    'port' => 6379,
  ),
  'instanceid' => 'INSTANCEID',
  'apps_paths' => 
  array (
    0 => 
    array (
      'path' => '/var/www/html/apps',
      'url' => '/apps',
      'writable' => false,
    ),
    1 => 
    array (
      'path' => '/var/www/html/custom_apps',
      'url' => '/custom_apps',
      'writable' => true,
    ),
  ),
);
