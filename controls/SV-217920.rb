# encoding: UTF-8

control "SV-217920" do
  title "The system must ignore ICMPv4 redirect messages by default."
  desc "This feature of the IPv4 protocol has few legitimate uses. It should be disabled unless it is absolutely required."
  desc "default", "This feature of the IPv4 protocol has few legitimate uses. It should
be disabled unless it is absolutely required."
  desc "check", "The status of the \"net.ipv4.conf.default.accept_redirects\" kernel parameter can be queried by running the following command:

$ sysctl net.ipv4.conf.default.accept_redirects
net.ipv4.conf.default.accept_redirects = 0

$ grep net.ipv4.conf.default.accept_redirects /etc/sysctl.conf /etc/sysctl.d/*
net.ipv4.conf.default.accept_redirects = 0

If \"net.ipv4.conf.default.accept_redirects\" is not configured in the /etc/sysctl.conf file or in the /etc/sysctl.d/ directory, is commented out or does not have a value of \"0\", this is a finding."
  desc "fix", "To set the runtime status of the \"net.ipv4.conf.default.accept_redirects\" kernel parameter, run the following command: 

# sysctl -w net.ipv4.conf.default.accept_redirects=0

Set the system to the required kernel parameter by adding the following line to \"/etc/sysctl.conf\" or a config file in the /etc/sysctl.d/ directory (or modify the line to have the required value):

net.ipv4.conf.default.accept_redirects = 0

Issue the following command to make the changes take effect:

# sysctl --system"
  impact 0.3
  ref 'DPMS Target Red Hat Enterprise Linux 6'
  tag gtitle: "SRG-OS-000480"
  tag gid: "V-217920"
  tag rid: "SV-217920r603264_rule"
  tag stig_id: "RHEL-06-000091"
  tag fix_id: "F-19399r376776_fix"
  tag cci: ["CCI-000366"]
  tag nist: ["CM-6 b", "Rev_4"]

  describe kernel_parameter("net.ipv4.conf.default.accept_redirects") do
    its("value") { should_not be_nil }
  end
  describe kernel_parameter("net.ipv4.conf.default.accept_redirects") do
    its("value") { should eq 0 }
  end
  describe file("/etc/sysctl.conf") do
    its("content") { should match(/^[\s]*net.ipv4.conf.default.accept_redirects[\s]*=[\s]*0[\s]*$/) }
  end
end