# encoding: UTF-8

control "SV-217992" do
  title "The TFTP service must not be running."
  desc "Disabling the \"tftp\" service ensures the system is not acting as a tftp server, which does not provide encryption or authentication."
  desc "default", "Disabling the \"tftp\" service ensures the system is not acting as a
tftp server, which does not provide encryption or authentication."
  desc "check", "To check that the \"tftp\" service is disabled in system boot configuration, run the following command:

# chkconfig \"tftp\" --list

Output should indicate the \"tftp\" service has either not been installed, or has been disabled, as shown in the example below:

# chkconfig \"tftp\" --list

tftp off

OR

error reading information on service tftp: No such file or directory

If the service is running and not documented and approved by the ISSO, this is a finding."
  desc "fix", "The \"tftp\" service should be disabled. The \"tftp\" service can be disabled with the following command: 

# chkconfig tftp off"
  impact 0.5
  ref 'DPMS Target Red Hat Enterprise Linux 6'
  tag gtitle: "SRG-OS-000095"
  tag gid: "V-217992"
  tag rid: "SV-217992r603264_rule"
  tag stig_id: "RHEL-06-000223"
  tag fix_id: "F-19471r376992_fix"
  tag cci: ["CCI-001436", "CCI-000381"]
  tag nist: ["AC-17 (8)", "Rev_4", "CM-7 a"]

  describe service('tftp') do
    it { should_not be_enabled }
    it { should_not be_running }
  end
end