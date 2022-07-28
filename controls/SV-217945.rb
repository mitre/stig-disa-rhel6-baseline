# encoding: UTF-8

control "SV-217945" do
  title "The operating system must employ automated mechanisms to facilitate the monitoring and control of remote access methods."
  desc "Ensuring the \"auditd\" service is active ensures audit records generated by the kernel can be written to disk, or that appropriate actions will be taken if other obstacles exist."
  desc "default", "Ensuring the \"auditd\" service is active ensures audit records
generated by the kernel can be written to disk, or that appropriate actions
will be taken if other obstacles exist."
  desc "check", "Run the following command to determine the current status of the \"auditd\" service: 

# service auditd status

If the service is enabled, it should return the following: 

auditd is running...


If the service is not running, this is a finding."
  desc "fix", "The \"auditd\" service is an essential userspace component of the Linux Auditing System, as it is responsible for writing audit records to disk. The \"auditd\" service can be enabled with the following commands: 

# chkconfig auditd on
# service auditd start"
  impact 0.5
  ref 'DPMS Target Red Hat Enterprise Linux 6'
  tag gtitle: "SRG-OS-000032"
  tag gid: "V-217945"
  tag rid: "SV-217945r603264_rule"
  tag stig_id: "RHEL-06-000148"
  tag fix_id: "F-19424r376851_fix"
  tag cci: ["CCI-000067"]
  tag nist: ["AC-17 (1)", "Rev_4"]

  describe service('auditd') do
    it { should be_enabled }
    it { should be_running }
  end
end