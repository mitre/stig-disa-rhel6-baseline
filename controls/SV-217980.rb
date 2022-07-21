# encoding: UTF-8

control "SV-217980" do
  title "The audit system must be configured to audit the loading and unloading of dynamic kernel modules."
  desc "The addition/removal of kernel modules can be used to alter the behavior of the kernel and potentially introduce malicious code into kernel space. It is important to have an audit trail of modules that have been introduced into the kernel."
  desc "default", "The addition/removal of kernel modules can be used to alter the
behavior of the kernel and potentially introduce malicious code into kernel
space. It is important to have an audit trail of modules that have been
introduced into the kernel."
  desc "check", "To determine if the system is configured to audit execution of module management programs, run the following commands:

$ sudo egrep -e \"(-w |-F path=)/sbin/insmod|(-w |-F path=)/sbin/rmmod|(-w |-F path=)/sbin/modprobe\" /etc/audit/audit.rules

-w /sbin/insmod -p x -k modules
-w /sbin/rmmod -p x -k modules
-w /sbin/modprobe -p x -k modules

If \"/sbin/insmod\" is not being audited, this is a finding.

If \"/sbin/rmmod\" is not being audited, this is a finding.

If \"/sbin/modprobe\" is not being audited, this is a finding.

To determine if the system is configured to audit calls to the \"init_module\" and \"delete_module\"  system calls, run the following command:

$ sudo egrep -w \"init_module|delete_module\" /etc/audit/audit.rules

-a always,exit -F arch=b32 -S init_module -S delete_module -k modules
-a always,exit -F arch=b64 -S init_module -S delete_module -k modules

If the system is 64-bit and does not return rules for both \"b32\" and \"b64\" architectures, this is a finding.

If the system is not configured to audit \"init_module\" this is a finding.
If the system is not configured to audit \"delete_module\", this is a finding.

If no line is returned, this is a finding."
  desc "fix", "Add the following to \"/etc/audit/audit.rules\" in order to capture kernel module loading and unloading events: 

-w /sbin/insmod -p x -k modules
-w /sbin/rmmod -p x -k modules
-w /sbin/modprobe -p x -k modules
-a always,exit -F arch=b32 -S init_module -S delete_module -k modules

If the system is 64-bit, then also add the following:

-a always,exit -F arch=b64 -S init_module -S delete_module -k modules"
  impact 0.5
  ref 'DPMS Target Red Hat Enterprise Linux 6'
  tag gtitle: "SRG-OS-000064"
  tag gid: "V-217980"
  tag rid: "SV-217980r603264_rule"
  tag stig_id: "RHEL-06-000202"
  tag fix_id: "F-19459r376956_fix"
  tag cci: ["CCI-000172"]
  tag nist: ["AU-12 c", "Rev_4"]

  describe file("/etc/audit/audit.rules") do
    its("content") { should match(/^(?:-w\s+|-a\s+(?:always,exit|exit,always)\s+-F\s+path=)\/sbin\/insmod\s+-p\s+[rwa]*x[rwa]*\s+-k\s+\S+\s*$/) }
  end
  describe file("/etc/audit/audit.rules") do
    its("content") { should match(/^(?:-w\s+|-a\s+(?:always,exit|exit,always)\s+-F\s+path=)\/sbin\/rmmod\s+-p\s+[rwa]*x[rwa]*\s+-k\s+\S+\s*$/) }
  end
  describe file("/etc/audit/audit.rules") do
    its("content") { should match(/^(?:-w\s+|-a\s+(?:always,exit|exit,always)\s+-F\s+path=)\/sbin\/modprobe\s+-p\s+[rwa]*x[rwa]*\s+-k\s+\S+\s*$/) }
  end
  describe file("/etc/audit/audit.rules") do
    its("content") { should match(/^[\s]*-a[\s](?:always,exit|exit,always)+(?:.*-F[\s]+arch=b32\s+).*(?:,|-S\s+)delete_module(?:,|\s+).*-k\s+\S+\s*$/) }
  end
  describe file("/etc/audit/audit.rules") do
    its("content") { should match(/^[\s]*-a[\s](?:always,exit|exit,always)(?:.*-F[\s]+arch=b32\s+).*(?:,|-S\s+)init_module(?:,|\s+).*-k\s+\S+\s*$/) }
  end
  describe.one do
  end
end