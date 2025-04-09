package 'cmake'

git "/tmp/sudo-touchid.darwin/github.com/yammerjp/pam_reattach" do
  repository "git@github.com:yammerjp/pam_reattach"
  # user "#{ENV['SUDO_USERS']}"
end

execute "cmake pam_reattach" do
  command "cmake -S . -B build -DCMAKE_BUILD_TYPE=Release -DCMAKE_INSTALL_PREFIX:PATH=/usr/local"
  cwd "/tmp/sudo-touchid.darwin/github.com/yammerjp/pam_reattach"
  not_if "test -e /usr/local/lib/pam/pam_reattach.so"
  # user "#{ENV['SUDO_USERS']}"
end

execute "install pam_reattach" do
  command "make install"
  cwd "/tmp/sudo-touchid.darwin/github.com/yammerjp/pam_reattach"
  not_if "test -e /usr/local/lib/pam/pam_reattach.so"
  user "root"
end

directory "/tmp/etc/pam.d"
remote_file "/tmp/etc/pam.d/sudo_local"

execute "create /etc/pam.d/sudo_local" do
  command "chown root:wheel /tmp/etc/pam.d/sudo_local && chmod 644 /tmp/etc/pam.d/sudo_local && mv /tmp/etc/pam.d/sudo_local /etc/pam.d/sudo_local"
  user "root"
end
