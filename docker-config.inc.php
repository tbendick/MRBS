<?php // -*-mode: PHP; coding:utf-8;-*-
namespace MRBS;

function docker_env(string $name, ?string $default = null): string
{
  $value = getenv($name);
  if (($value === false) || ($value === '')) {
    if ($default !== null) {
      return $default;
    }
    throw new \RuntimeException("Required environment variable {$name} is not set");
  }
  return $value;
}

$timezone = docker_env('MRBS_TIMEZONE', 'America/New_York');

$dbsys = docker_env('MRBS_DB_SYSTEM', 'mysql');
$db_host = docker_env('MRBS_DB_HOST', 'db');
$db_database = docker_env('MRBS_DB_DATABASE');
$db_login = docker_env('MRBS_DB_USER');
$db_password = docker_env('MRBS_DB_PASSWORD');
$db_tbl_prefix = docker_env('MRBS_DB_TBL_PREFIX', 'mrbs_');
$db_persist = false;

/* Add lines from systemdefaults.inc.php and areadefaults.inc.php below here
   to change the default configuration. Do _NOT_ modify systemdefaults.inc.php
   or areadefaults.inc.php.  */
