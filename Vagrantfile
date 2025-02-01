Vagrant.configure("2") do |config|
  NUM_WORKERS = 2
  config.vm.box = "cloud-image/ubuntu-24.04" # Sostituisci con una box compatibile con Libvirt
  config.vm.define "master" do |master|
      master.vm.provider "libvirt" do |libvirt|
        libvirt.memory = 8192       # RAM in MB (8 GB)
        libvirt.cpus = 2            # Numero di CPU
      end
      master.vm.hostname = "master"
      master.vm.network "private_network", ip: "192.168.100.101", virtualbox__intnet: "kubenet"
      master.vm.provision "file", source: "./provision/.ssh/id_rsa", destination: "/home/vagrant/.ssh/id_rsa"
      master.vm.provision "file", source: "./provision/.ssh/id_rsa.pub", destination: "/home/vagrant/.ssh/id_rsa.pub"
      master.vm.provision "shell", inline: <<-SHELL
        cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
      SHELL
      master.vm.provision "shell", path: "./provision/common.sh", args: [NUM_WORKERS]
      master.vm.provision "shell", path: "./provision/master.sh", args: [NUM_WORKERS]
  end
  (1..NUM_WORKERS).each do |i|
    config.vm.define "worker#{i}" do |worker|
      worker.vm.box = "cloud-image/ubuntu-24.04"
      worker.vm.hostname = "worker#{i}"
      worker.vm.network "private_network", ip: "192.168.100.#{101 + i}", virtualbox__intnet: "kubenet"
      worker.vm.provider "libvirt" do |libvirt|
        libvirt.memory = 8192
        libvirt.cpus = 2
      end
      worker.vm.provision "file", source: "./provision/.ssh/id_rsa", destination: "/home/vagrant/.ssh/id_rsa"
      worker.vm.provision "file", source: "./provision/.ssh/id_rsa.pub", destination: "/home/vagrant/.ssh/id_rsa.pub"
      worker.vm.provision "shell", inline: <<-SHELL
        cat /home/vagrant/.ssh/id_rsa.pub >> /home/vagrant/.ssh/authorized_keys
      SHELL
      worker.vm.provision "shell", path: "./provision/common.sh", args: [NUM_WORKERS]
    end
  end
end
