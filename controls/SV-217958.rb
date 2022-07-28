# encoding: UTF-8

control "SV-217958" do
  title "The operating system must automatically audit account disabling actions."
  desc "In addition to auditing new user and group accounts, these watches will alert the system administrator(s) to any modifications. Any unexpected users, groups, or modifications should be investigated for legitimacy."
  desc "default", "In addition to auditing new user and group accounts, these watches
will alert the system administrator(s) to any modifications. Any unexpected
users, groups, or modifications should be investigated for legitimacy."
  desc "check", "To determine if the system is configured to audit account changes, run the following command: 

$sudo egrep -w '(/etc/passwd|/etc/shadow|/etc/group|/etc/gshadow|/etc/security/opasswd)' /etc/audit/audit.rules

If the system is configured to watch for account changes, lines should be returned for each file specified (and with \"-p wa\" for each). 

If the system is not configured to audit account changes, this is a finding."
  desc "fix", "Add the following to \"/etc/audit/audit.rules\", in order to capture events that modify account changes: 

# audit_account_changes
-w /etc/group -p wa -k audit_account_changes
-w /etc/passwd -p wa -k audit_account_changes
-w /etc/gshadow -p wa -k audit_account_changes
-w /etc/shadow -p wa -k audit_account_changes
-w /etc/security/opasswd -p wa -k audit_account_changes"
  impact 0.3
  ref 'DPMS Target Red Hat Enterprise Linux 6'
  tag gtitle: "SRG-OS-000240"
  tag gid: "V-217958"
  tag rid: "SV-217958r603264_rule"
  tag stig_id: "RHEL-06-000176"
  tag fix_id: "F-19437r376890_fix"
  tag cci: ["CCI-001404"]
  tag nist: ["AC-2 (4)", "Rev_4"]

  describe file("/etc/audit/audit.rules") do
    its("content") { should match(/^\-w\s+\/etc\/group\s+\-p\s+wa\s+\-k\s+\w+\s*$/) }
  end
  describe file("/etc/audit/audit.rules") do
    its("content") { should match(/^\-w\s+\/etc\/passwd\s+\-p\s+wa\s+\-k\s+\w+\s*$/) }
  end
  describe file("/etc/audit/audit.rules") do
    its("content") { should match(/^\-w\s+\/etc\/gshadow\s+\-p\s+wa\s+\-k\s+\w+\s*$/) }
  end
  describe file("/etc/audit/audit.rules") do
    its("content") { should match(/^\-w\s+\/etc\/shadow\s+\-p\s+wa\s+\-k\s+\w+\s*$/) }
  end
  describe file("/etc/audit/audit.rules") do
    its("content") { should match(/^\-w\s+\/etc\/security\/opasswd\s+\-p\s+wa\s+\-k\s+\w+\s*$/) }
  end
end