# encoding: UTF-8

control "SV-217963" do
  title "The audit system must be configured to audit all discretionary access control permission modifications using chown."
  desc "The changing of file permissions could indicate that a user is attempting to gain access to information that would otherwise be disallowed. Auditing DAC modifications can facilitate the identification of patterns of abuse among both authorized and unauthorized users."
  desc "default", "The changing of file permissions could indicate that a user is
attempting to gain access to information that would otherwise be disallowed.
Auditing DAC modifications can facilitate the identification of patterns of
abuse among both authorized and unauthorized users."
  desc "check", "To determine if the system is configured to audit calls to the \"chown\" system call, run the following command:

$ sudo grep -w \"chown\" /etc/audit/audit.rules

-a always,exit -F arch=b32 -S chown -F auid>=500 -F auid!=4294967295 \\
-k perm_mod
-a always,exit -F arch=b32 -S chown -F auid=0 -k perm_mod
-a always,exit -F arch=b64 -S chown -F auid>=500 -F auid!=4294967295 \\
-k perm_mod
-a always,exit -F arch=b64 -S chown -F auid=0 -k perm_mod

If the system is 64-bit and does not return a rule for both \"b32\" and \"b64\" architectures, this is a finding.

If the system is not configured to audit the \"chown\" system call, this is a finding."
  desc "fix", "At a minimum, the audit system should collect file permission changes for all users and root. Add the following to \"/etc/audit/audit.rules\": 

-a always,exit -F arch=b32 -S chown -F auid>=500 -F auid!=4294967295 \\
-k perm_mod
-a always,exit -F arch=b32 -S chown -F auid=0 -k perm_mod

If the system is 64-bit, then also add the following: 

-a always,exit -F arch=b64 -S chown -F auid>=500 -F auid!=4294967295 \\
-k perm_mod
-a always,exit -F arch=b64 -S chown -F auid=0 -k perm_mod"
  impact 0.3
  ref 'DPMS Target Red Hat Enterprise Linux 6'
  tag gtitle: "SRG-OS-000064"
  tag gid: "V-217963"
  tag rid: "SV-217963r603264_rule"
  tag stig_id: "RHEL-06-000185"
  tag fix_id: "F-19442r376905_fix"
  tag cci: ["CCI-000172"]
  tag nist: ["AU-12 c", "Rev_4"]

  describe file("/etc/audit/audit.rules") do
    its("content") { should match(/^[\s]*-a[\s](?:always,exit|exit,always)+(?:.*-F[\s]+arch=b32[\s]+)(?:.*(?:-S[\s]+|,)chown(?:[\s]+|,))(?:.*-F\s+auid>=500[\s]+)(?:.*-F\s+auid!=(?:-1|4294967295)[\s]+).*-k[\s]+[\S]+[\s]*$/) }
  end
  describe file("/etc/audit/audit.rules") do
    its("content") { should match(/^[\s]*-a[\s](?:always,exit|exit,always)+(?:.*-F[\s]+arch=b32[\s]+)(?:.*(?:-S[\s]+|,)chown(?:[\s]+|,))(?:.*-F\s+auid=0[\s]+).*-k[\s]+[\S]+[\s]*$/) }
  end
  describe.one do
  end
end