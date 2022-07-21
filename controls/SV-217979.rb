# encoding: UTF-8

control "SV-217979" do
  title "The audit system must be configured to audit changes to the /etc/sudoers file."
  desc "The actions taken by system administrators should be audited to keep a record of what was executed on the system, as well as, for accountability purposes."
  desc "default", "The actions taken by system administrators should be audited to keep a
record of what was executed on the system, as well as, for accountability
purposes."
  desc "check", "To verify that auditing is configured for system administrator actions, run the following command: 

$ sudo grep -w \"/etc/sudoers\" /etc/audit/audit.rules

If the system is configured to watch for changes to its sudoers configuration, a line should be returned (including \"-p wa\" indicating permissions that are watched). 

If there is no output, this is a finding."
  desc "fix", "At a minimum, the audit system should collect administrator actions for all users and root. Add the following to \"/etc/audit/audit.rules\": 

-w /etc/sudoers -p wa -k actions"
  impact 0.3
  ref 'DPMS Target Red Hat Enterprise Linux 6'
  tag gtitle: "SRG-OS-000064"
  tag gid: "V-217979"
  tag rid: "SV-217979r603264_rule"
  tag stig_id: "RHEL-06-000201"
  tag fix_id: "F-19458r376953_fix"
  tag cci: ["CCI-000172"]
  tag nist: ["AU-12 c", "Rev_4"]

  describe file("/etc/audit/audit.rules") do
    its("content") { should match(/^\-w\s+\/etc\/sudoers\s+\-p\s+wa\s+\-k\s+[-\w]+\s*$/) }
  end
end