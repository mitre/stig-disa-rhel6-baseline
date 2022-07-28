# encoding: UTF-8

control "SV-217860" do
  title "There must be no .rhosts or hosts.equiv files on the system."
  desc "Trust files are convenient, but when used in conjunction with the R-services, they can allow unauthenticated access to a system."
  desc "default", "Trust files are convenient, but when used in conjunction with the
R-services, they can allow unauthenticated access to a system."
  desc "check", "The existence of the file \"/etc/hosts.equiv\" or a file named \".rhosts\" inside a user home directory indicates the presence of an Rsh trust relationship. 
If these files exist, this is a finding."
  desc "fix", "The files \"/etc/hosts.equiv\" and \"~/.rhosts\" (in each user's home directory) list remote hosts and users that are trusted by the local system when using the rshd daemon. To remove these files, run the following command to delete them from any location. 

# rm /etc/hosts.equiv



$ rm ~/.rhosts"
  impact 0.7
  ref 'DPMS Target Red Hat Enterprise Linux 6'
  tag gtitle: "SRG-OS-000480"
  tag gid: "V-217860"
  tag rid: "SV-217860r603264_rule"
  tag stig_id: "RHEL-06-000019"
  tag fix_id: "F-19339r376596_fix"
  tag cci: ["CCI-001436", "CCI-000366"]
  tag nist: ["AC-17 (8)", "Rev_4", "CM-6 b"]

  describe file("/root/^\\.(r|s)hosts$") do
    it { should_not exist }
  end
  describe command("find /home -regex .\\*/\\^\\\\.\\(r\\|s\\)hosts\\$ -type f  -maxdepth 1") do
    its("stdout") { should be_empty }
  end
  describe file("/etc/^s?hosts\\.equiv$") do
    it { should_not exist }
  end
end