class ipa ( $ipa_realm       = "EXAMPLE.COM",
            $ipa_join_user   = "admin", 
	    $ipa_domain	     = "example.com",
            $ipa_join_pw     = "changeme",
            $ipa_server_1     = "ipa01.example.com",
            $ipa_server_2     = "ipa02.example.com",
                ) 
{

include stdlib

# Command to Run to Join to IPA Domain
$command_string = "/usr/sbin/ipa-client-install --principal $ipa_join_user@$ipa_realm --password $ipa_join_pw --domain $ipa_domain --server $ipa_server_1 --server $ipa_server_2 --mkhomedir --unattended --force -N"

package { "ipa-client":
	ensure      => installed,
	}

exec { "ipa_installer":
	command     => $command_string,
	unless      => '/usr/sbin/ipa-client-install --unattended 2>&1 | /bin/grep -q "already configured"',
	require     => Package["ipa-client"],
	}

#if $operatingsystem == "RedHat" and $operatingsystemmajrelease == 6 {
#	file_line { 'dns_lookup_realm':
#		path    => '/etc/krb5.conf',
#		line    => "  dns_lookup_realm = true",
#		match   => '[\s]dns_lookup_realm',
#		ensure  => present,
#		}
#
#	file_line { 'dns_lookup_kdc':
#		path    => '/etc/krb5.conf',
#		line    => "  dns_lookup_kdc = true",
#		match   => '[\s]dns_lookup_kdc',
#		ensure  => present,
#		}
#}

}
