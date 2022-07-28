# encoding: UTF-8

control "SV-218109" do
  title "The Red Hat Enterprise Linux operating system must mount /dev/shm with the nosuid option."
  desc "The \"nosuid\" mount option causes the system to not execute \"setuid\" and \"setgid\" files with owner privileges. This option must be used for mounting any file system not containing approved \"setuid\" and \"setguid\" files. Executing files from untrusted file systems increases the opportunity for unprivileged users to attain unauthorized administrative access."
  desc "default", "The \"nosuid\" mount option causes the system to not execute
\"setuid\" and \"setgid\" files with owner privileges. This option must be used
for mounting any file system not containing approved \"setuid\" and \"setguid\"
files. Executing files from untrusted file systems increases the opportunity
for unprivileged users to attain unauthorized administrative access."
  desc "check", "Verify that the \"nosuid\" option is configured for /dev/shm.

Check that the operating system is configured to use the \"nosuid\" option for /dev/shm with the following command:

# cat /etc/fstab | grep /dev/shm | grep nosuid

tmpfs   /dev/shm   tmpfs   defaults,nodev,nosuid,noexec   0 0

If the \"nosuid\" option is not present on the line for \"/dev/shm\", this is a finding.

Verify \"/dev/shm\" is mounted with the \"nosuid\" option:

# mount | grep \"/dev/shm\" | grep nosuid

If no results are returned, this is a finding."
  desc "fix", "Configure the \"/etc/fstab\" to use the \"nosuid\" option for all lines containing \"/dev/shm\"."
  impact 0.3
  ref 'DPMS Target Red Hat Enterprise Linux 6'
  tag gtitle: "SRG-OS-000368"
  tag gid: "V-218109"
  tag rid: "SV-218109r603264_rule"
  tag stig_id: "RHEL-06-000531"
  tag fix_id: "F-19588r377343_fix"
  tag cci: ["CCI-001764"]
  tag nist: ["CM-7 (2)", "Rev_4"]

  describe file("/etc/fstab") do
    its("content") { should match(/^[^#\s]+[ \t]+\/dev\/shm[ \t]+[\w\d]+[ \t]+([\w,]+)\s*.*$/) }
  end
  file("/etc/fstab").content.to_s.scan(/^[^#\s]+[ \t]+\/dev\/shm[ \t]+[\w\d]+[ \t]+([\w,]+)\s*.*$/).flatten.each do |entry|
    describe entry do
      it { should match(/^(?:nosuid|[\w,]+,nosuid)(?:$|,[\w,]+$)/) }
    end
  end
  describe file("/etc/mtab") do
    its("content") { should match(/^[^#\s]+[ \t]+\/dev\/shm[ \t]+[\w\d]+[ \t]+([\w,]+)\s*.*$/) }
  end
  file("/etc/mtab").content.to_s.scan(/^[^#\s]+[ \t]+\/dev\/shm[ \t]+[\w\d]+[ \t]+([\w,]+)\s*.*$/).flatten.each do |entry|
    describe entry do
      it { should match(/^(?:nosuid|[\w,]+,nosuid)(?:$|,[\w,]+$)/) }
    end
  end
end