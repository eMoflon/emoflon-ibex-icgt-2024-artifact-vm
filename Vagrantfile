Vagrant.configure("2") do |config|
    config.vm.box = "emoflon"
    config.vm.define 'emoflon'
    config.vm.provider :virtualbox do |vb|
        vb.name = "emoflon-icgt"
        vb.memory = 8192
        vb.cpus = 2
    end

    # Copy eMoflon::IBeX-specific files
    config.vm.provision "file", source: "./resources/updatesite-emoflon.zip", destination: "updatesite-emoflon.zip"
    config.vm.provision "file", source: "./resources/updatesite-hipe.zip", destination: "updatesite-hipe.zip"
    # config.vm.provision "file", source: "./resources/workspace.zip", destination: "workspace.zip"
    # config.vm.provision "file", source: "./resources/content-onto-desktop/ArtifactEvaluation.pdf", destination: "Desktop/ArtifactEvaluation.pdf"
    # config.vm.provision "shell", inline: "mkdir -p /home/vagrant/Desktop/paper-eval-results && chown -R vagrant:vagrant /home/vagrant/Desktop/paper-eval-results"
    # config.vm.provision "file", source: "./resources/content-onto-desktop/paper-eval-results/Benchmark_HO-SC-Horizontal.txt", destination: "Desktop/paper-eval-results/Benchmark_HO-SC-Horizontal.txt"
    # config.vm.provision "file", source: "./resources/content-onto-desktop/paper-eval-results/Benchmark_HO-SC-Vertical.txt", destination: "Desktop/paper-eval-results/Benchmark_HO-SC-Vertical.txt"
    # config.vm.provision "file", source: "./resources/content-onto-desktop/paper-eval-results/Benchmark_HO-SC-VerticalMultiChange.txt", destination: "Desktop/paper-eval-results/Benchmark_HO-SC-VerticalMultiChange.txt"
    # TODO

    # Provisioning script
    config.vm.provision "shell", path: "prov.sh", privileged: false

    # Prevent SharedFoldersEnableSymlinksCreate errors
    config.vm.synced_folder ".", "/vagrant", disabled: true

    config.ssh.username = 'vagrant'
    config.ssh.password = 'vagrant'
    config.ssh.insert_key = false
end
