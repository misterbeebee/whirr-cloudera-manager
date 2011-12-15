set -x
function install_cloudera_manager() {
  yum install -y expect
  installer=cloudera-manager-installer.bin
  wget http://archive.cloudera.com/scm/installer/latest/$installer
  chmod u+x $installer
  
  # Need to use expect for the install since script expects user to hit enter
  # at the end
  cat >> install <<END
#!/usr/bin/expect -f
set timeout 300
spawn ./$installer --ui=stdio --noprompt --noreadme --nooptions --i-agree-to-all-licenses
expect "*hit enter*"
send -- "\n"
expect EOF
END

  chmod +x install
  ./install
}
