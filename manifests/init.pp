# == Class: phpipam
#
# Full description of class phpipam here.
#
# === Parameters
#
# [*sample_parameter*]
#   Explanation of what this parameter affects and what it defaults to.
#
class phpipam (
  $apache_docroot         = $::phpipam::params::apache_docroot,
  $apache_user            = $::phpipam::params::apache_user,
  $apache_group           = $::phpipam::params::apache_group,
  $package_source         = $::phpipam::params::package_source,
  $manage_apache          = true,
  $manage_php             = true,
  $manage_mysql           = true,
  $apache_server_root     = $::phpipam::params::apache_server_root,
  $apache_serveradmin     = $::phpipam::params::apache_serveradmin,
  $mysql_root_password    = 'strongpassword',
  $php_timezone           = $::timezone,
  $site_fqdn              = $::fqdn,
  $ssl_certificate        = false,
  $ssl_key                = false,
  $ssl_ca_certs           = false,
  $ssl_chain_certs        = false,
  $ssl_enabled            = false,
  $enable_pingcheck_cron  = true,
  $ssl_options            = {},
) inherits phpipam::params {

  if $::osfamily == 'Redhat' {
  # validate parameters here
  validate_absolute_path( $apache_docroot,
                          $apache_server_root,
  )
  validate_string($apache_user,
                  $apache_group,
                  $apache_serveradmin,
                  $php_timezone,
  )
  validate_hash($ssl_options)
  validate_bool(  $manage_apache,
                  $manage_php,
                  $manage_mysql,
                  $enable_pingcheck_cron,
  )

  class { 'phpipam::install': } ->
  class { 'phpipam::config': } ~>
  class { 'phpipam::service': } ->
  Class['phpipam']

  }
  else {
    fail("${::osfamily} not supported")
  }
}
