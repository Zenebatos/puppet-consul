# == Class: consul
#
# Installs, configures and manages consul
#
# === Parameters
#
# [*acls*]
#   Hash of consul_acl resources to create.
#
# [*tokens*]
#   Hash of consul_token resources to create.
#
# [*policies*]
#   Hash of consul_policy resources to create.
#
# [*acl_api_hostname*]
#   Global hostname of ACL API, will be merged with consul_token resources
#
# [*acl_api_protocol*]
#   Global protocl of ACL API, will be merged with consul_token resources
#
# [*acl_api_port*]
#   Global port of ACL API, will be merged with consul_token resources
#
# [*acl_api_tries*]
#   Global max. tries of ACL API, will be merged with consul_token resources
#
# [*acl_api_token*]
#   Global token of ACL API, will be merged with consul_token resources
#
# [*arch*]
#   Architecture of consul binary to download.
#
# [*archive_path*]
#   Path used when installing consul via the url.
#
# [*bin_dir*]
#   Directory to create the symlink to the consul binary in.
#
# [*binary_group*]
#   The group that the file belongs to.
#
# [*binary_mode*]
#   Permissions mode for the file.
#
# [*binary_name*]
#   The binary name file.
#
# [*binary_owner*]
#   The user that owns the file.
#
# [*checks*]
#   Hash of consul::check resources to create.
#
# [*config_defaults*]
#   Configuration defaults hash. Gets merged with config_hash.
#
# [*config_dir*]
#   Directory to place consul configuration files in.
#
# [*config_hash*]
#   Use this to populate the JSON config file for consul.
#
# [*config_mode*]
#   Use this to set the JSON config file mode for consul.
#
# [*data_dir_mode*]
#   Use this to set the data_dir directory mode for consul.
#
# [*docker_image*]
#   Only valid when the install_method == docker. Defaults to `consul`.
#
# [*download_extension*]
#   The extension of the archive file containing the consul binary to download.
#
# [*download_url*]
#   Fully qualified url to the location of the archive file containing the consul binary.
#
# [*download_url_base*]
#   Base url to the location of the archive file containing the consul binary.
#
# [*extra_groups*]
#   Extra groups to add the consul system user to.
#
# [*extra_options*]
#   Extra arguments to be passed to the consul agent
#
# [*group*]
#   Name of the group that should own the consul configuration files.
#
# [*init_style*]
#   What style of init system your system uses. Set to 'unmanaged' to disable
#   managing init system files for the consul service entirely.
#   This is ignored when install_method == 'docker'
#
# [*install_method*]
#   Valid strings: `docker`  - install via docker container
#                  `package` - install via system package
#                  `url`     - download and extract from a url. Defaults to `url`.
#                  `none`    - disable install.
#
# [*join_wan*]
#   The wan to join on service start (e.g. 'wan.foo.com'). Defaults to undef (i.e. won't join a wan).
#
# [*manage_group*]
#   Whether to create/manage the group that should own the consul configuration files.
#
# [*manage_service*]
#   Whether to manage the consul service.
#
# [*manage_user*]
#   Whether to create/manage the user that should own consul's configuration files.
#
# [*manage_data_dir*]
#   Whether to manage the consul storage data directory.
#
# [*os*]
#   OS component in the name of the archive file containing the consul binary.
#
# [*package_ensure*]
#   Only valid when the install_method == package. Defaults to `latest`.
#
# [*package_name*]
#   Only valid when the install_method == package. Defaults to `consul`.
#
# [*pretty_config*]
#   Generates a human readable JSON config file. Defaults to `false`.
#
# [*pretty_config_indent*]
#   Toggle indentation for human readable JSON file. Defaults to `4`.
#
# [*proxy_server*]
#   Specify a proxy server, with port number if needed. ie: https://example.com:8080.
#
# [*purge_config_dir*]
#   Purge config files no longer generated by Puppet
#
# [*restart_on_change*]
#   Determines whether to restart consul agent on $config_hash changes.
#   This will not affect reloads when service, check or watch configs change.
#   Defaults to `true`.
#
# [*service_enable*]
#   Whether to enable the consul service to start at boot.
#
# [*service_ensure*]
#   Whether the consul service should be running or not.
#
# [*services*]
#   Hash of consul::service resources to create.
#
# [*user*]
#   Name of the user that should own the consul configuration files.
#
# [*version*]
#   Specify version of consul binary to download.
#
# [*watches*]
#   Hash of consul::watch resources to create.
#
# [*shell*]
#   The shell for the consul user. Defaults to something that prohibits login, like /usr/sbin/nologin
#
# [*enable_beta_ui*]
#   consul 1.1.0 introduced a new UI, which is currently (2018-05-12) in beta status.
#   You can enable it by setting this variable to true. Defaults to false
#
# [*allow_binding_to_root_ports*]
#   Boolean, enables CAP_NET_BIND_SERVICE if true. This is currently only implemented on systemd nodes
#
# [*log_file*]
#   String, where should the log file be located
#
# === Examples
#
#  @example
#    class { 'consul':
#      config_hash => {
#        'datacenter'   => 'east-aws',
#        'node_name'    => $facts['fqdn'],
#        'pretty_config => true,
#        'retry-join'   => ['172.16.0.1'],
#      },
#    }
#
class consul (
  $acls                        = {},
  $tokens                      = {},
  $policies                    = {},
  $acl_api_hostname            = 'localhost',
  $acl_api_protocol            = 'http',
  $acl_api_port                = 8500,
  $acl_api_tries               = 3,
  $acl_api_token               = '',
  $arch                        = $consul::params::arch,
  $archive_path                = undef,
  $bin_dir                     = $consul::params::bin_dir,
  $binary_group                = $consul::params::binary_group,
  $binary_mode                 = $consul::params::binary_mode,
  $binary_name                 = $consul::params::binary_name,
  $binary_owner                = $consul::params::binary_owner,
  $checks                      = {},
  $config_defaults             = $consul::params::config_defaults,
  $config_dir                  = $consul::params::config_dir,
  $config_hash                 = {},
  $config_mode                 = '0664',
  $data_dir_mode               = $consul::params::data_dir_mode,
  $docker_image                = 'consul',
  $download_extension          = 'zip',
  $download_url                = undef,
  $download_url_base           = 'https://releases.hashicorp.com/consul/',
  $extra_groups                = [],
  $extra_options               = undef,
  $group                       = $consul::params::group,
  $log_file                    = '/var/log/consul',
  $init_style                  = $consul::params::init_style,
  $install_method              = 'url',
  $join_wan                    = undef,
  $manage_group                = $consul::params::manage_group,
  $manage_service              = true,
  $manage_user                 = $consul::params::manage_user,
  $manage_data_dir             = true,
  $os                          = downcase($facts['kernel']),
  $package_ensure              = 'latest',
  $package_name                = 'consul',
  $pretty_config               = false,
  $pretty_config_indent        = 4,
  $proxy_server                = undef,
  $purge_config_dir            = true,
  $restart_on_change           = true,
  $service_enable              = true,
  $service_ensure              = 'running',
  $services                    = {},
  $user                        = $consul::params::user,
  $version                     = '1.2.3',
  $watches                     = {},
  $shell                       = $consul::params::shell,
  $enable_beta_ui              = false,
  $allow_binding_to_root_ports = false,
) inherits consul::params {

  $real_download_url = pick($download_url, "${download_url_base}${version}/${package_name}_${version}_${os}_${arch}.${download_extension}")

  $config_hash_real = deep_merge($config_defaults, $config_hash)

  if $install_method == 'docker' {
    $user_real       = undef
    $group_real      = undef
    $init_style_real = 'unmanaged'
  } else {
    $user_real       = $user
    $group_real      = $group
    $init_style_real = $init_style
  }

  if $config_hash_real['data_dir'] {
    $data_dir = $config_hash_real['data_dir']
  } else {
    $data_dir = undef
  }

  if dig($config_hash_real,'ports','http') {
    $http_port = $config_hash_real['ports']['http']
  } else {
    $http_port = 8500
  }

  if dig($config_hash_real,'ports','https') {
    $https_port = $config_hash_real['ports']['https']
  } else {
    $https_port = Undef
  }

  if dig($config_hash_real,'addresses','http') {
    $http_addr_parts = split($config_hash_real['addresses']['http'], ' ')
    $http_addr = $http_addr_parts[0]
  } elsif ($config_hash_real['client_addr']) {
    $http_addr_parts = split($config_hash_real['client_addr'], ' ')
    $http_addr = $http_addr_parts[0]
  } else {
    $http_addr = '127.0.0.1'
  }

  if dig($config_hash_real,'verify_incoming') {
    $verify_incoming = $config_hash_real['verify_incoming']
  } else {
    $verify_incoming = false
  }

  if dig($config_hash_real,'cert_file') {
    $cert_file = $config_hash_real['cert_file']
  } else {
    $cert_file = Undef
  }

  if dig($config_hash_real,'key_file') {
    $key_file = $config_hash_real['key_file']
  } else {
    $key_file = Undef
  }

  if $services {
    create_resources(consul::service, $services)
  }

  if $watches {
    create_resources(consul::watch, $watches)
  }

  if $checks {
    create_resources(consul::check, $checks)
  }

  if $acls {
    create_resources(consul_acl, $acls)
  }

  contain 'consul::install'
  contain 'consul::config'
  contain 'consul::run_service'
  contain 'consul::reload_service'

  Class['consul::install']
  -> Class['consul::config']
  -> Class['consul::run_service']
  -> Class['consul::reload_service']

  if $restart_on_change {
    Class['consul::config']
    ~> Class['consul::run_service']
  }

  $global_acl_config = {
    'hostname'      => $acl_api_hostname,
    'protocol'      => $acl_api_protocol,
    'port'          => $acl_api_port,
    'api_tries'     => $acl_api_tries,
    'acl_api_token' => $acl_api_token,
  }

  # TODO: This may break. Complex logic was in place and replaced by this.
  create_resources(consul_policy, policies, global_acl_config)
  create_resources(consul_token, tokens, global_acl_config)

}
