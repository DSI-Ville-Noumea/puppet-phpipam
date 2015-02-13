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
  $apache_docroot = $::phpipam::params::apache_docroot,
  $apache_user    = $::phpipam::params::apache_user,
  $apache_group   = $::phpipam::params::apache_group,
  $package_source = $::phpipam::params::package_source,
) inherits phpipam::params {

  if $::osfamily == 'Redhat' {
  # validate parameters here
  validate_absolute_path($apache_docroot)
  validate_string($apache_user,
                  $apache_group
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
