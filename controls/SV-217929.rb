# encoding: UTF-8

control "SV-217929" do
  title "The operating system must prevent public IPv6 access into an organizations internal networks, except as appropriately mediated by managed interfaces employing boundary protection devices."
  desc "The \"ip6tables\" service provides the system's host-based firewalling capability for IPv6 and ICMPv6."
  desc "default", "The \"ip6tables\" service provides the system's host-based firewalling
capability for IPv6 and ICMPv6."
  desc "check", "If the system is a cross-domain system, this is not applicable.

If IPv6 is disabled, this is not applicable.

Run the following command to determine the current status of the \"ip6tables\" service: 

# service ip6tables status

If the service is not running, it should return the following: 

ip6tables: Firewall is not running.


If the service is not running, this is a finding."
  desc "fix", "The \"ip6tables\" service can be enabled with the following commands: 

# chkconfig ip6tables on
# service ip6tables start"
  impact 0.5
  ref 'DPMS Target Red Hat Enterprise Linux 6'
  tag gtitle: "SRG-OS-000480"
  tag gid: "V-217929"
  tag rid: "SV-217929r603264_rule"
  tag stig_id: "RHEL-06-000107"
  tag fix_id: "F-19408r376803_fix"
  tag cci: ["CCI-001100", "CCI-000366"]
  tag nist: ["SC-7 (2)", "Rev_4", "CM-6 b"]

  describe service('ip6tables') do
    it { should be_enabled }
    it { should be_running }
  end
end