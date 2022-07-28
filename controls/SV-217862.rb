# encoding: UTF-8

control "SV-217862" do
  title "The Red Hat Enterprise Linux operating system must not contain .shosts or shosts.equiv files."
  desc "The .shosts and shosts.equiv files are used to configure host-based authentication for the system via SSH. Host-based authentication is not sufficient for preventing unauthorized access to the system, as it does not require interactive identification and authentication of a connection request, or for the use of two-factor authentication."
  desc "check", "Verify there are no \".shosts\" or \"shosts.equiv\" files on the system.

# find / -name '*.shosts'

# find / -name shosts.equiv

If any \".shosts\" or \"shosts.equiv\" files are found on the system, this is a finding."
  desc "fix", "Remove any found \".shosts\" or \"shosts.equiv\" files from the system.

# rm /[path]/[to]/[file]/.shosts
# rm /[path]/[to]/[file]/shosts.equiv"
  impact 0.7
  ref 'DPMS Target Red Hat Enterprise Linux 6'
  tag check_id: "C-19343r462695_chk"
  tag severity: "high"
  tag gid: "V-217862"
  tag rid: "SV-217862r603264_rule"
  tag stig_id: "RHEL-06-000021"
  tag gtitle: "SRG-OS-000480"
  tag fix_id: "F-19341r462696_fix"
  tag legacy: ["V-100011", "SV-109115"]
  tag cci: ["CCI-000366"]
  tag nist: ["CM-6 b"]
end