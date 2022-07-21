# encoding: UTF-8

control "SV-217922" do
  title "The system must ignore ICMPv4 bogus error responses."
  desc "Ignoring bogus ICMP error responses reduces log size, although some activity would not be logged."
  desc "default", "Ignoring bogus ICMP error responses reduces log size, although some
activity would not be logged."
  desc "check", "The status of the \"net.ipv4.icmp_ignore_bogus_error_responses\" kernel parameter can be queried by running the following command:

$ sysctl net.ipv4.icmp_ignore_bogus_error_responses
net.ipv4.icmp_ignore_bogus_error_responses = 1

$ grep net.ipv4.icmp_ignore_bogus_error_responses /etc/sysctl.conf /etc/sysctl.d/*
net.ipv4.icmp_ignore_bogus_error_responses = 1

If \"net.ipv4.icmp_ignore_bogus_error_responses\" is not configured in the /etc/sysctl.conf file or in the /etc/sysctl.d/ directory, is commented out or does not have a value of \"1\", this is a finding."
  desc "fix", "To set the runtime status of the \"net.ipv4.icmp_ignore_bogus_error_responses\" kernel parameter, run the following command: 

# sysctl -w net.ipv4.icmp_ignore_bogus_error_responses=1

Set the system to the required kernel parameter by adding the following line to \"/etc/sysctl.conf\" or a config file in the /etc/sysctl.d/ directory (or modify the line to have the required value): 

net.ipv4.icmp_ignore_bogus_error_responses = 1

Issue the following command to make the changes take effect:

# sysctl --system"
  impact 0.3
  ref 'DPMS Target Red Hat Enterprise Linux 6'
  tag gtitle: "SRG-OS-000480"
  tag gid: "V-217922"
  tag rid: "SV-217922r603264_rule"
  tag stig_id: "RHEL-06-000093"
  tag fix_id: "F-19401r376782_fix"
  tag cci: ["CCI-000366"]
  tag nist: ["CM-6 b", "Rev_4"]

  describe kernel_parameter("net.ipv4.icmp_ignore_bogus_error_responses") do
    its("value") { should_not be_nil }
  end
  describe kernel_parameter("net.ipv4.icmp_ignore_bogus_error_responses") do
    its("value") { should eq 1 }
  end
  describe file("/etc/sysctl.conf") do
    its("content") { should match(/^[\s]*net.ipv4.icmp_ignore_bogus_error_responses[\s]*=[\s]*1[\s]*$/) }
  end
end