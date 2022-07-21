# encoding: UTF-8

control "SV-217849" do
  title "The system must use a separate file system for the system audit data path."
  desc "Placing \"/var/log/audit\" in its own partition enables better separation between audit files and other files, and helps ensure that auditing cannot be halted due to the partition running out of space."
  desc "default", "Placing \"/var/log/audit\" in its own partition enables better
separation between audit files and other files, and helps ensure that auditing
cannot be halted due to the partition running out of space."
  desc "check", "Run the following command to determine if \"/var/log/audit\" is on its own partition or logical volume: 

$ mount | grep \"on /var/log/audit \"

If \"/var/log/audit\" has its own partition or volume group, a line will be returned. 
If no line is returned, this is a finding."
  desc "fix", "Audit logs are stored in the \"/var/log/audit\" directory. Ensure that it has its own partition or logical volume at installation time, or migrate it later using LVM. Make absolutely certain that it is large enough to store all audit logs that will be created by the auditing daemon."
  impact 0.3
  ref 'DPMS Target Red Hat Enterprise Linux 6'
  tag gtitle: "SRG-OS-000480"
  tag gid: "V-217849"
  tag rid: "SV-217849r603264_rule"
  tag stig_id: "RHEL-06-000004"
  tag fix_id: "F-19328r376563_fix"
  tag cci: ["CCI-000137", "CCI-000366"]
  tag nist: ["AU-4", "Rev_4", "CM-6 b"]

  describe mount("/var/log/audit") do
    it { should be_mounted }
  end
end