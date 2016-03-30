class ipa ( $ipa_realm       = "EXAMPLE.COM",
            $ipa_join_user   = "admin", 
	    $ipa_domain	     = "example.com",
            $ipa_join_pw     = "changeme",
            $ipa_server_1     = "ipa01.example.com",
            $ipa_server_2     = "ipa02.example.com",
                ) 
{


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

}
