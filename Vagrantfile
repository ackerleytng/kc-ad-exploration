Vagrant.configure("2") do |config|
  config.vm.box = "opentable/win-2012r2-standard-amd64-nocm"

  # For LDAP
  config.vm.network "forwarded_port", guest: 389, host: 3389
  # For LDAPS
  config.vm.network "forwarded_port", guest: 636, host: 6636

  config.vm.provider "virtualbox" do |v|
    v.gui = true
  end

  config.ssh.extra_args = ["-o", "HostKeyAlgorithms=+ssh-dss"]
  config.ssh.shell = "powershell"
end
