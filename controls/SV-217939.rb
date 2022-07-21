# encoding: UTF-8

control "SV-217939" do
  title "All rsyslog-generated log files must be group-owned by root."
  desc "The log files generated by rsyslog contain valuable information regarding system configuration, user authentication, and other such information. Log files should be protected from unauthorized access."
  desc "default", "The log files generated by rsyslog contain valuable information
regarding system configuration, user authentication, and other such
information. Log files should be protected from unauthorized access."
  desc "check", "The group-owner of all log files written by \"rsyslog\" should be root. These log files are determined by the second part of each Rule line in \"/etc/rsyslog.conf\" and typically all appear in \"/var/log\". To see the group-owner of a given log file, run the following command:

$ ls -l [LOGFILE]

Some log files referenced in /etc/rsyslog.conf may be created by other programs and may require exclusion from consideration.

If the group-owner is not root, this is a finding."
  desc "fix", "The group-owner of all log files written by \"rsyslog\" should be root. These log files are determined by the second part of each Rule line in \"/etc/rsyslog.conf\" and typically all appear in \"/var/log\". For each log file [LOGFILE] referenced in \"/etc/rsyslog.conf\", run the following command to inspect the file's group owner:

$ ls -l [LOGFILE]

If the owner is not \"root\", run the following command to correct this:

# chgrp root [LOGFILE]"
  impact 0.5
  ref 'DPMS Target Red Hat Enterprise Linux 6'
  tag gtitle: "SRG-OS-000206"
  tag gid: "V-217939"
  tag rid: "SV-217939r603264_rule"
  tag stig_id: "RHEL-06-000134"
  tag fix_id: "F-19418r376833_fix"
  tag cci: ["CCI-001314"]
  tag nist: ["SI-11 b", "Rev_4"]

  # strip comments, empty lines, and lines which start with $ in order to get rules
  rules = file('/etc/rsyslog.conf').content.lines.map do |l|
    pound_index = l.index('#')
    l = l.slice(0, pound_index) if !pound_index.nil?
    l.strip
  end.reject { |l| l.empty? or l.start_with? '$' }
  paths = rules.map do |r|
    filter, action = r.split(%r{\s+})
    next if !(action.start_with? '-/' or action.start_with? '/')
    action.sub(%r{^-/}, '/')
  end.reject { |path| path.nil? }
  if paths.empty?
    describe "rsyslog log files" do
      subject { paths }
      it { should be_empty }
    end
  else
    paths.each do |path|
      describe file(path) do 
        its('group') { should eq 'root' }
      end
    end
  end
end