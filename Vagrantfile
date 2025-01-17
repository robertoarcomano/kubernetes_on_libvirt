Vagrant.configure("2") do |config|
  config.vm.box = "generic/ubuntu2004" # Sostituisci con una box compatibile con Libvirt
  config.vm.define "master" do |master|
      master.vm.provider "libvirt" do |libvirt|
        libvirt.memory = 8192       # RAM in MB (8 GB)
        libvirt.cpus = 2            # Numero di CPU
      end
      master.vm.hostname = "master"
      master.vm.network "private_network", ip: "192.168.100.101", virtualbox__intnet: "kubenet"
      master.vm.hostname = "master"
  end
  config.vm.define "worker1" do |worker1|
      worker1.vm.provider "libvirt" do |libvirt|
        libvirt.memory = 8192       # RAM in MB (8 GB)
        libvirt.cpus = 2            # Numero di CPU
      end
      worker1.vm.network "private_network", ip: "192.168.100.102", virtualbox__intnet: "kubenet"
      worker1.vm.hostname = "worker1"
  end
  config.vm.define "worker2" do |worker2|
      worker2.vm.provider "libvirt" do |libvirt|
        libvirt.memory = 8192       # RAM in MB (8 GB)
        libvirt.cpus = 2            # Numero di CPU
      end
      worker2.vm.network "private_network", ip: "192.168.100.103", virtualbox__intnet: "kubenet"
      worker2.vm.hostname = "worker2"
  end
end
