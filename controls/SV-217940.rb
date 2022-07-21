# encoding: UTF-8

control "SV-217940" do
  title "All rsyslog-generated log files must have mode 0600 or less permissive."
  desc "Log files can contain valuable information regarding system configuration. If the system log files are not protected, unauthorized users could change the logged data, eliminating their forensic value."
  desc "default", "Log files can contain valuable information regarding system
configuration. If the system log files are not protected, unauthorized users
could change the logged data, eliminating their forensic value."
  desc "check", "The file permissions for all log files written by rsyslog should be set to 600, or more restrictive. These log files are determined by the second part of each Rule line in \"/etc/rsyslog.conf\" and typically all appear in \"/var/log\". For each log file [LOGFILE] referenced in \"/etc/rsyslog.conf\", run the following command to inspect the file's permissions: 

$ ls -l [LOGFILE]

The permissions should be 600, or more restrictive. Some log files referenced in /etc/rsyslog.conf may be created by other programs and may require exclusion from consideration.

If the permissions are not correct, this is a finding."
  desc "fix", "The file permissions for all log files written by rsyslog should be set to 600, or more restrictive. These log files are determined by the second part of each Rule line in \"/etc/rsyslog.conf\" and typically all appear in \"/var/log\". For each log file [LOGFILE] referenced in \"/etc/rsyslog.conf\", run the following command to inspect the file's permissions:

$ ls -l [LOGFILE]

If the permissions are not 600 or more restrictive, run the following command to correct this:

# chmod 0600 [LOGFILE]"
  impact 0.5
  ref 'DPMS Target Red Hat Enterprise Linux 6'
  tag gtitle: "SRG-OS-000206"
  tag gid: "V-217940"
  tag rid: "SV-217940r603264_rule"
  tag stig_id: "RHEL-06-000135"
  tag fix_id: "F-19419r376836_fix"
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
        it { should_not be_executable }
        it { should_not be_readable.by('group') }
        it { should_not be_writable.by('group') }
        it { should_not be_readable.by('others') }
        it { should_not be_writable.by('others') }
      end
    end
  end
end