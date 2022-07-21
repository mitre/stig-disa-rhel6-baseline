# encoding: UTF-8

control "SV-218093" do
  title "The audit system must take appropriate action when the audit storage volume is full."
  desc "Taking appropriate action in case of a filled audit storage volume will minimize the possibility of losing audit records."
  desc "default", "Taking appropriate action in case of a filled audit storage volume
will minimize the possibility of losing audit records."
  desc "check", "Inspect \"/etc/audit/auditd.conf\" and locate the following line to determine if the system is configured to take appropriate action when the audit storage volume is full:

# grep disk_full_action /etc/audit/auditd.conf
disk_full_action = [ACTION]


If the system is configured to \"suspend\" when the volume is full or \"ignore\" that it is full, this is a finding."
  desc "fix", "The \"auditd\" service can be configured to take an action when disk space starts to run low. Edit the file \"/etc/audit/auditd.conf\". Modify the following line, substituting [ACTION] appropriately: 

disk_full_action = [ACTION]

Possible values for [ACTION] are described in the \"auditd.conf\" man page. These include: 

\"ignore\"
\"syslog\"
\"exec\"
\"suspend\"
\"single\"
\"halt\"


Set this to \"syslog\", \"exec\", \"single\", or \"halt\"."
  impact 0.5
  ref 'DPMS Target Red Hat Enterprise Linux 6'
  tag gtitle: "SRG-OS-000047"
  tag gid: "V-218093"
  tag rid: "SV-218093r603264_rule"
  tag stig_id: "RHEL-06-000510"
  tag fix_id: "F-19572r377295_fix"
  tag cci: ["CCI-000140"]
  tag nist: ["AU-5 b", "Rev_4"]

  describe parse_config_file('/etc/audit/auditd.conf') do
    its('disk_full_action') { should_not be_nil }
    its('disk_full_action.downcase') { should_not be_in ['suspend', 'ignore'] }
  end
end