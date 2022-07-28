# encoding: UTF-8

control "SV-218022" do
  title "Remote file systems must be mounted with the nosuid option."
  desc "NFS mounts should not present suid binaries to users. Only vendor-supplied suid executables should be installed to their default location on the local filesystem."
  desc "default", "NFS mounts should not present suid binaries to users. Only
vendor-supplied suid executables should be installed to their default location
on the local filesystem."
  desc "check", "To verify the \"nosuid\" option is configured for all NFS mounts, run the following command: 

$ mount | grep nfs

All NFS mounts should show the \"nosuid\" setting in parentheses, along with other mount options. 
If the setting does not show, this is a finding."
  desc "fix", "Add the \"nosuid\" option to the fourth column of \"/etc/fstab\" for the line which controls mounting of any NFS mounts."
  impact 0.5
  ref 'DPMS Target Red Hat Enterprise Linux 6'
  tag gtitle: "SRG-OS-000480"
  tag gid: "V-218022"
  tag rid: "SV-218022r603264_rule"
  tag stig_id: "RHEL-06-000270"
  tag fix_id: "F-19501r377082_fix"
  tag cci: ["CCI-000366"]
  tag nist: ["CM-6 b", "Rev_4"]

  describe command('mount | grep nfs') do
    its('stdout.strip.lines') { should all include 'nosuid' }
  end
end